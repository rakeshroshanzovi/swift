//
//  DeviceInfo.swift
//  CustomButton
//
//  Created by Shashank Shandilya on 16/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import Foundation

class DeviceInfo {
    class func getDeviceInfo() -> Dictionary<String, String>{
        return ["id" : UIDevice.currentDevice().identifierForVendor.UUIDString]
    }
}