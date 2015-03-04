//
//  ReminderVC.swift
//  Daily Three
//
//  Created by Mollie on 3/3/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class ReminderVC: UIViewController {

    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var notificationTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var settings:[String:AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: make placeholder text gray
        
        // TODO: add observer
        
        // NSUserDefaults
        if defaults.objectForKey("settings") != nil {
            settings = defaults.objectForKey("settings") as [String:AnyObject]
        }
        
        // TODO: if they approve notifications when first launching the app, set notificationOn = true, else set it = false and when they turn it on, set it = true
        
//        format of settings:
//        ["notificationOn":true,
//         "notificationText":"Remember your Daily Three",
//         "notificationTime":timePicker.date]
        if settings["notificationOn"] != nil {
            reminderSwitch.on = settings["notificationOn"] as Bool
        }
        if settings["notificationTime"] != nil {
            timePicker.date = settings["notificationTime"] as NSDate
        }
        if settings["notificationText"] != nil {
            notificationTextField.text = settings["notificationText"] as String
        }
        
        navigationController?.navigationBar.translucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "saveReminder")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if reminderSwitch.on {
            
            notificationLabel.hidden = false
            notificationTextField.hidden = false
            timePicker.hidden = false
            
        } else {
            
            notificationLabel.hidden = true
            notificationTextField.hidden = true
            timePicker.hidden = true
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: add animation for hiding/showing
    @IBAction func switched(sender: AnyObject) {
        
        notificationLabel.hidden = notificationLabel.hidden == true ? false : true
        notificationTextField.hidden = notificationTextField.hidden == true ? false : true
        timePicker.hidden = timePicker.hidden == true ? false : true
        
    }
    
    func saveReminder() {
        
        settings["notificationOn"] = reminderSwitch.on
        settings["notificationText"] = notificationTextField.text
        settings["notificationTime"] = timePicker.date
        defaults.setValue(settings, forKey: "settings")
        
        if reminderSwitch.on == true {
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            scheduleLocalNotification()
            
        } else {
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
        }

        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    func scheduleLocalNotification() {
        
        let notificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Sound
        let notificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        let notification = UILocalNotification()
//        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.fireDate = timePicker.date
        notification.repeatInterval = NSCalendarUnit.DayCalendarUnit
        notification.timeZone = NSTimeZone.defaultTimeZone()
        if let alertText = settings["notificationText"] as? String {
            if alertText == "" {
                notification.alertBody = "Remember your Daily Three"
            } else {
                notification.alertBody = alertText
            }
        } else {
            notification.alertBody = "Remember your Daily Three"
        }
        //            notification.alertAction = "View List"
        //            notification.soundName = "Glass.aiff"
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    

}
