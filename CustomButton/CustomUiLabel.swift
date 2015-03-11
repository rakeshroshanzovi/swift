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
        let ZzoviCustomLabel = UILabel(frame: (dic["frame"] as NSValue).CGRectValue())
        ZzoviCustomLabel.backgroundColor = dic["backgroundcolor"] as? UIColor
        var view = dic["view"] as? UIViewController
        var myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
        ZzoviCustomLabel.layer.borderColor = myColor.CGColor
        ZzoviCustomLabel.layer.borderWidth = 1.0
        ZzoviCustomLabel.text = dic["text"] as? String
        view?.view?.addSubview(ZzoviCustomLabel)
        return ZzoviCustomLabel
    }
}
