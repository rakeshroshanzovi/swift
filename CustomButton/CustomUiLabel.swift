//
//  CustomUiLabel.swift
//  CustomButton
//
//  Created by Rakesh Roshan on 11/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import UIKit

class CustomUiLabel: UILabel {
    class func zoviCustomLabel(dic:Dictionary <String, AnyObject>)->UILabel {
        let ZzoviCustomLabel = UILabel()
        SwiftTryCatch.try({
            // try something
            if dic["frame"] == nil {
                var error :NSError = NSError(domain: "uiLabelError", code: 1, userInfo: ["frame error":"No Frame set for the label"])
                NSException.raise("custom label", format:"Error: %@", arguments:getVaList([error ?? "nil"]))
            } else {
                        ZzoviCustomLabel.frame = (dic["frame"] as NSValue).CGRectValue()
            }
            //        if dic["backgroundcolor"] ?? "defaultValue" {
            if dic["backgroundcolor"] == nil {
                ZzoviCustomLabel.backgroundColor = UIColor.whiteColor()
            } else {
                ZzoviCustomLabel.backgroundColor = dic["backgroundcolor"] as? UIColor
            }
            var myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
            ZzoviCustomLabel.layer.borderColor = myColor.CGColor
            ZzoviCustomLabel.layer.borderWidth = 1.0
            ZzoviCustomLabel.text = dic["text"] as? String
            if dic["view"] == nil {
                var error :NSError = NSError(domain: "uiLabelError", code: 2, userInfo: ["view error":"No view is sent"])
                NSException.raise("custom label", format:"Error: %@", arguments:getVaList([error ?? "nil"]))
            } else {
                var view = dic["view"] as? UIView
                view?.addSubview(ZzoviCustomLabel)
            }
            }, catch: { (NSError) in
                println("sring error \(NSError.description)\n")
            })
        return ZzoviCustomLabel
    }
}
