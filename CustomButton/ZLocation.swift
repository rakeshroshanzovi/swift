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
var seenError : Bool = false
var locationFixAchieved : Bool = false
var locationStatus : NSString = "Not Started"

class ZLocation: NSObject,CLLocationManagerDelegate {
    
    
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        ZlocationManager.delegate = self
        ZlocationManager.desiredAccuracy = kCLLocationAccuracyBest
        ZlocationManager.requestWhenInUseAuthorization()
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
        
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as CLLocation
            var coord = locationObj.coordinate
            
            println(coord.latitude)
            println(coord.longitude)
        }
        
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            
            switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
                shouldIAllow = true
            }
            if (shouldIAllow == true) {
                NSLog("Location to Allowed")
                // Start location services
                ZlocationManager.startUpdatingLocation()
                ZlocationManager.startMonitoringSignificantLocationChanges()
            } else {
                NSLog("Denied access: \(locationStatus)")
            }
    }
    
    class func sendLocationUpdateafterEvery(time:CGFloat) {
//        var timeToSet:NSTimeInterval = time
//    var timer = NSTimer.scheduledTimerWithTimeInterval(timeToSet, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() {
        self.needLocationUpdate()
    }
    
    func needLocationUpdate(){
        locationFixAchieved = false
    }
}

