//
//  CustomUITextField.swift
//  CustomButton
//
//  Created by Rakesh Roshan on 11/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    private func newBounds(bounds: CGRect) -> CGRect {
        
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= (padding.top * 2) - padding.bottom
        newBounds.size.width -= (padding.left * 2) - padding.right
        return newBounds
    }
}

class CustomUITextField: UITextField {
    class func customTextField(dic:Dictionary <String, AnyObject>) {
        var frame = (dic["frame"] as NSValue).CGRectValue()
        var CustomTextField = TextField(frame: (dic["frame"] as NSValue).CGRectValue())
        CustomTextField.placeholder = dic["placeholder"] as? String
        var view = dic["view"] as? UIViewController
        var myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
        CustomTextField.layer.borderColor = myColor.CGColor
        CustomTextField.layer.borderWidth = 1.0
        view?.view?.addSubview(CustomTextField)
    }
}


