//
//  AppDelegate.swift
//  CustomButton
//
//  Created by Rakesh Roshan on 11/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var internetReach:Reachability?
    var connectionAvail:CInt = CInt()

    var location:ZLocation = ZLocation()
    var time:CGFloat = 600.0
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        // Override point for customization after application launch.
        MTReachabilityManager.sharedManager()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("hasConnectivity:"), name: kReachabilityChangedNotification, object: nil)
        window = UIWindow(frame: UIScreen.mainScreen().bounds);
        let navigationController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navigationController;
        window!.makeKeyAndVisible()
        location.initLocationManager()
        location.sendLocationUpdateafterEvery(600.0)
        var contacts:getContact = getContact()
        contacts.initContact()
        
        return true
    }


    func hasConnectivity(notification:NSNotification) {

        var reachability:Reachability  = notification.object as Reachability;
        
        if reachability.isReachable(){
            connectionAvail = 1
        } else {
            connectionAvail = 2
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        location.toStopTimer()
        location.backgroundActivity(600.0)
//        location.forSignificantLocationChange()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        location.toStopTimer()
        location.sendLocationUpdateafterEvery(600.0)
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        location.forSignificantLocationChange()
    }


}

