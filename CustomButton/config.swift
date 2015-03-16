//
//  config.swift
//  CustomButton
//
//  Created by Shashank Shandilya on 16/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import Foundation

class ConfigLoader : NSObject {
    
    class var resource: ConfigLoader { //computed type
        struct Static { // stored type
            static var instance: ConfigLoader?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) { //make it thread safe
            Static.instance = ConfigLoader()
        }
        
        return Static.instance!
    }
    
    let timeStamp: NSDate
    let config: NSDictionary
    
    override init() {
      self.timeStamp = NSDate()
        self.config  = [ "hello" : "world"]
    }
    
}