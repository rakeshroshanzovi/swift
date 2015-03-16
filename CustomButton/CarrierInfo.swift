//
//  CarrierInfo.swift
//  CustomButton
//
//  Created by Shashank Shandilya on 16/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import Foundation
import CoreTelephony

class CarrierInfo {
    class func getCarrierInfo() -> Dictionary<String, String>{
        var carrier = CTCarrier()
        var carrier_name = ""
        var carrier_code = ""
        
        if (carrier.carrierName? != nil) {
            carrier_name = carrier.carrierName
        }
        if (carrier.mobileNetworkCode  != nil ){
            carrier_code = carrier.mobileNetworkCode
        }
        println( carrier.carrierName )
        return ["name" : carrier_name, "code" : carrier_code ]
    }
}