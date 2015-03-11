//
//  ViewController.swift
//  UIControllTest
//
//  Created by Rakesh Roshan on 11/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.hidden = true
        self.view.backgroundColor = UIColor.whiteColor()
        let myFirstButton = UIButton()
        myFirstButton.frame = CGRectMake(100, 200, 100, 200)
        myFirstButton.backgroundColor = UIColor.blackColor()
        self.view.addSubview(myFirstButton)
        myFirstButton.addTarget(self, action:"myFirstButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func myFirstButtonAction(sender:UIButton!){
        let secondView = tableviewView()
        self.navigationController?.pushViewController(secondView, animated:true)
        sender.backgroundColor = UIColor.blueColor()
    }
}

