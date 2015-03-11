//
//  ViewController.swift
//  CustomButton
//
//  Created by Rakesh Roshan on 11/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        var testButton = ZCustomButton.ZzoviButton(CGRectMake(100, 100, 200, 100), color: UIColor.blackColor(), view: self.view)
//        let aVariable = zoviButton.zoviButton(CGRectMake(100, 100, 200, 100), color: UIColor.blackColor())
//        self.view .addSubview(aVariable)
        testButton.addTarget(self, action:"myFirstButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func myFirstButtonAction(sender:UIButton!){

        sender.backgroundColor = UIColor.blueColor()
    }

}

