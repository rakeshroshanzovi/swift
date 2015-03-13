//
//  ZLocation.swift
//  CustomButton
//
//  Created by Rakesh Roshan on 13/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import UIKit
import CoreLocation

var ZlocationManager = CLLocationManager()
var seenError : Bool = true
var locationFixAchieved : Bool = false
var locationStatus : NSString = "Not Started"
var timer:NSTimer = NSTimer()

class ZLocation: NSObject,CLLocationManagerDelegate {
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    
    func initLocationManager() {
        seenError = false
        locationFixAchieved = true
        ZlocationManager.delegate = self
        ZlocationManager.desiredAccuracy = kCLLocationAccuracyBest
        ZlocationManager.requestAlwaysAuthorization()
        ZlocationManager.startUpdatingLocation()

        
       
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        ZlocationManager.stopUpdatingLocation()
        if (error != nil) {
            if seenError == false {
                seenError = true
                print(error)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as CLLocation
            var coord = locationObj.coordinate
            
        
        
        if locationFixAchieved == true {
            println(coord.latitude)
            println(coord.longitude)
            ZlocationManager = manager
            self.hitServerWithData()
        manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            
            // App may no longer be authorized to obtain location
            //information. Check status here and respond accordingly.
            
    }
    
    func hitServerWithData() {
        locationFixAchieved = false
        var param:[String:AnyObject] = ["action":"location","latitude":ZlocationManager.location.coordinate.latitude,"longitude":ZlocationManager.location.coordinate.longitude]
        var connection:ZConnection = ZConnection( requestUrl: "http://54.179.30.135/trace", type: "GET", withParam: param)
        connection.processRequsetWithCompletion({ (recieveddata:NSData!,httpStatusCode:NSInteger) in
            println(httpStatusCode)
            },{(error: NSError!) in
                println("error")
        })

    }
    
    func sendLocationUpdateafterEvery(time:NSTimeInterval) {
    timer = NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: Selector("update:"), userInfo: nil, repeats: true)
    }
    
    
    func backgroundActivity(time:NSTimeInterval) {
        backgroundTaskIdentifier = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({
            UIApplication.sharedApplication().endBackgroundTask(self.backgroundTaskIdentifier!)
        })
        timer = NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: Selector("updateInBackGround:"), userInfo: nil, repeats: true)
    }
    
    
    func update(timer: NSTimer) {
        locationFixAchieved = true
        ZlocationManager.startUpdatingLocation()
    }
    
    func updateInBackGround(timer: NSTimer) {
         locationFixAchieved = true
        ZlocationManager.delegate = self
        ZlocationManager.desiredAccuracy = kCLLocationAccuracyBest
        ZlocationManager.requestAlwaysAuthorization()
        ZlocationManager.startUpdatingLocation()
    }
    
    
    func forSignificantLocationChange(){
        locationFixAchieved = false
        ZlocationManager.delegate = self
        ZlocationManager.desiredAccuracy = kCLLocationAccuracyBest
        ZlocationManager.requestAlwaysAuthorization()
        ZlocationManager.startMonitoringSignificantLocationChanges()
    }
    
    func toStopTimer() {
        timer.invalidate()
    }
    
}

