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
//        var dic = ["abc":"rakesh"]
//        //dic = ["abc":"rakesh"]
//        dic["sha"] = "shashank"
//        println(dic["sha"])
//        var testButton = ZCustomButton.ZzoviButton(CGRectMake(100, 100, 200, 100), color: UIColor.blackColor(), view: self.view)
        var testButton = ZCustomButton.ZzoviButton(CGRectMake(100, 100, 200, 100), color: UIColor.blackColor(), view: self.view)

        testButton.addTarget(self, action:"myFirstButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        var dic:[String:AnyObject] = ["frame":NSValue(CGRect:CGRectMake(20, 300, 300, 50)),"placeholder":"rakesh","view":self]

         CustomUITextField.customTextField(dic)
        var labelDic:[String:AnyObject] = ["frame":NSValue(CGRect:CGRectMake(20, 380, 300, 50)),"backgroundcolor":UIColor.greenColor(),"view":self,"text":"Zovi label"];
        CustomUiLabel.zoviCustomLabel(labelDic)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func myFirstButtonAction(sender:UIButton!){

        sender.backgroundColor = UIColor.blueColor()
    }

}

