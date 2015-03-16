//
//  getContact.swift
//  CustomButton
//
//  Created by Rakesh Roshan on 16/03/15.
//  Copyright (c) 2015 Rakesh Roshan. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI


class getContact: NSObject {
     var adbk : ABAddressBook!
    func initContact(){
        var authorized:Bool = self.determineStatus()
        if authorized {
            self.getContactNames()
        }
    }
   
    
    func createAddressBook() -> Bool {
        if self.adbk != nil {
            return true
        }
        var err : Unmanaged<CFError>? = nil
        let adbk : ABAddressBook? = ABAddressBookCreateWithOptions(nil, &err).takeRetainedValue()
        if adbk == nil {
            println(err)
            self.adbk = nil
            return false
        }
        self.adbk = adbk
        return true
    }
    
    func determineStatus() -> Bool {
        let status = ABAddressBookGetAuthorizationStatus()
        switch status {
        case .Authorized:
            return self.createAddressBook()
        case .NotDetermined:
            var ok = false
            ABAddressBookRequestAccessWithCompletion(nil) {
                (granted:Bool, err:CFError!) in
                dispatch_async(dispatch_get_main_queue()) {
                    if granted {
                        ok = self.createAddressBook()
                    }
                }
            }
            if ok == true {
                return true
            }
            self.adbk = nil
            return false
        case .Restricted:
            self.adbk = nil
            return false
        case .Denied:
            self.adbk = nil
            return false
        }
    }
    
    func getContactNames() {
        if !self.determineStatus() {
            println("not authorized")
            return
        }
        let people = ABAddressBookCopyArrayOfAllPeople(adbk).takeRetainedValue() as NSArray as [ABRecord]
        for person in people {
            println(ABRecordCopyCompositeName(person).takeRetainedValue())
            /* Get all the phone numbers this user has */
            let unmanagedPhones = ABRecordCopyValue(person, kABPersonPhoneProperty)
            let phones: ABMultiValueRef =
            Unmanaged.fromOpaque(unmanagedPhones.toOpaque()).takeUnretainedValue()
                as NSObject as ABMultiValueRef
            
            let countOfPhones = ABMultiValueGetCount(phones)
            
            for index in 0..<countOfPhones{
                let unmanagedPhone = ABMultiValueCopyValueAtIndex(phones, index)
                let phone: String = Unmanaged.fromOpaque(
                    unmanagedPhone.toOpaque()).takeUnretainedValue() as NSObject as String
                
                println(phone)
            }
        }
    }
}
