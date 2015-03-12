//
//  AppDelegate.swift
//  CustomButton
//
//  Created by Rakesh Roshan on 11/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import UIKit
//var reachability:Reachability?
//let ZREACHABLEWITHWIFI = "reachableWithWIFI"
//let ZNOTREACHABLE = "notReachable"
//let ZREACHABLEWITHWWAN = "reachableWithWWAN"
//var reachabilityStatus = ZREACHABLEWITHWWAN
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var internetReach:Reachability?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        internetReach = Reachability.reachabilityForInternetConnection()
        internetReach?.startNotifier()
        if internetReach != nil {
            self.hasConnectivity()
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hasConnectivity", name: kReachabilityChangedNotification, object: nil)
        window = UIWindow(frame: UIScreen.mainScreen().bounds);
        let navigationController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navigationController;
        window!.makeKeyAndVisible()
        return true
    }

//    func statusChangeWithReachability(statusChangedWithReachability:Reachability) {
//        var statusOfNetwork :NetworkStatus = statusChangedWithReachability.currentReachabilityStatus()
//        println("networksatus: \(statusOfNetwork.value)")
        
//    }
    func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().value
        println("networkStatus: \(networkStatus)")
        return networkStatus != 0
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

