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
        
        var config1 = ConfigLoader.resource
        var config2 = ConfigLoader.resource
        
        if config1 === config2{
            println("hello dad! we are twins")
            println("config\(config1.config)")
        }else{
            println("sorry wait for another 9 months")
        }
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        var testButton = ZCustomButton.ZzoviButton(CGRectMake(100, 100, 200, 100), color: UIColor.blackColor(), view: self.view)

        testButton.addTarget(self, action:"myFirstButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        var dic:[String:AnyObject] = ["frame":NSValue(CGRect:CGRectMake(20, 300, 300, 50)),"placeholder":"rakesh","view":self]

         CustomUITextField.customTextField(dic)
        var labelDic:[String:AnyObject] = ["frame":NSValue(CGRect:CGRectMake(20, 380, 300, 50)),"view":self.view,"text":"Zovi label"];
        CustomUiLabel.zoviCustomLabel(labelDic)
    }
    
    func makeConnection() {
        var connection:ZConnection = ZConnection( requestUrl: "http://www.google.com", type: "GET", withParam: nil)
        connection.processRequsetWithCompletion({ (recieveddata:NSData!,httpStatusCode:NSInteger) in
            println(httpStatusCode)
            },{(error: NSError!) in
                println("error")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func myFirstButtonAction(sender:UIButton!){

        sender.backgroundColor = UIColor.blueColor()
        self.makeConnection()
    }

}

