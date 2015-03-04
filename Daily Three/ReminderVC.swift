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
        
        if reminderSwitch.on == true {
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()

            let notificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
            let notificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
            
            let notification = UILocalNotification()
            notification.fireDate = timePicker.date
            notification.timeZone = NSTimeZone.defaultTimeZone()
            notification.repeatInterval = NSCalendarUnit.DayCalendarUnit
            notification.alertBody = notificationTextField.text
//            notification.soundName = "Glass.aiff"
            notification.alertAction = "View List"
            //            notification.applicationIconBadgeNumber = 1
            
            println(notification)
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            
        } else {
            
            // cancel any notifications
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
        }
        
        // TODO: save time, on/off, notificationTextField.text to NSUserDefaults
        
        settings["notificationOn"] = reminderSwitch.on
        settings["notificationText"] = notificationTextField.text
        settings["notificationTime"] = timePicker.date
        defaults.setValue(settings, forKey: "settings")

        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
//    // MARK: Notifications
//    func setupNotificationSettings() {
//        // Specify the notification types.
//        var notificationTypes: UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Sound
//        
//        var justInformAction = UIMutableUserNotificationAction()
//        justInformAction.identifier = "justInform"
//        justInformAction.title = "OK, got it"
//        justInformAction.activationMode = UIUserNotificationActivationMode.Background
//        justInformAction.destructive = false
//        justInformAction.authenticationRequired = false
//        
//        var modifyListAction = UIMutableUserNotificationAction()
//        modifyListAction.identifier = "editList"
//        modifyListAction.title = "Edit list"
//        modifyListAction.activationMode = UIUserNotificationActivationMode.Foreground
//        modifyListAction.destructive = false
//        modifyListAction.authenticationRequired = true
//        
//        var trashAction = UIMutableUserNotificationAction()
//        trashAction.identifier = "trashAction"
//        trashAction.title = "Delete list"
//        trashAction.activationMode = UIUserNotificationActivationMode.Background
//        trashAction.destructive = true
//        trashAction.authenticationRequired = true
//        
//        let actionsArray = NSArray(objects: justInformAction, modifyListAction, trashAction)
//        let actionsArrayMinimal = NSArray(objects: trashAction, modifyListAction)
//        
//        // Specify the category related to the above actions.
//        var shoppingListReminderCategory = UIMutableUserNotificationCategory()
//        shoppingListReminderCategory.identifier = "shoppingListReminderCategory"
//        shoppingListReminderCategory.setActions(actionsArray, forContext: UIUserNotificationActionContext.Default)
//        shoppingListReminderCategory.setActions(actionsArrayMinimal, forContext: UIUserNotificationActionContext.Minimal)
//        
//        
//        let categoriesForSettings = NSSet(objects: shoppingListReminderCategory)
//        
//        
//        // Register the notification settings.
//        let newNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: categoriesForSettings)
//        UIApplication.sharedApplication().registerUserNotificationSettings(newNotificationSettings)
//        
//        // FIXME: is there a way to cancel the notification if the app is active?
//        
//    }
//    
//    
//    func scheduleLocalNotification() {
//        
//        
//        var localNotification = UILocalNotification()
//        localNotification.fireDate = timePicker.date
//        localNotification.timeZone = NSTimeZone.defaultTimeZone()
//        localNotification.repeatInterval = NSCalendarUnit.DayCalendarUnit
//        localNotification.alertBody = notificationTextField.text
//        localNotification.alertAction = "View List"
//        
//        localNotification.category = "shoppingListReminderCategory"
//        
//        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
//    }
    

}
