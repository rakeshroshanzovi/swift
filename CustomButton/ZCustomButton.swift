//
//  ZCustomButton.swift
//  CustomButton
//
//  Created by Rakesh Roshan on 11/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import UIKit

class ZCustomButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    class func ZzoviButton(frame:CGRect, color:UIColor, view:UIView)->UIButton {
        let zoviCustomButton = UIButton()
//        if frame == nil {
//            frame = CGRectMake(100, 100, 200, 100);
//        }
         zoviCustomButton.frame = frame
        zoviCustomButton.backgroundColor = color
        view.addSubview(zoviCustomButton)
        return zoviCustomButton
    }

}
