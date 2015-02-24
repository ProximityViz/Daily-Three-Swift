//
//  AppDelegate.swift
//  Daily Three
//
//  Created by Mollie on 2/8/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

let darkPrimary = UIColor(red:0.75, green:0.28, blue:0.04, alpha:1)
//let mediumPrimary = UIColor(red:1, green:0.65, blue:0.4, alpha:1)
let mediumPrimary = UIColor(red:0.85, green:0.55, blue:0.24, alpha:1)
let lightPrimary = UIColor(red:0.98, green:0.87, blue:0.57, alpha:1)
let darkSecondary = UIColor(red:0, green:0.05, blue:0.18, alpha:1)
let headerFont = "Avenir-Light"
let primaryFont = "Avenir-Book"
let boldFont = "Avenir-Heavy"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIBarButtonItem.appearance().tintColor = lightPrimary
        UINavigationBar.appearance().tintColor = lightPrimary
        UITableView.appearance().backgroundColor = lightPrimary
        UITableView.appearance().separatorColor = darkPrimary
        UITableViewCell.appearance().backgroundColor = lightPrimary
        var bgColorView = UIView()
        bgColorView.backgroundColor = mediumPrimary
        UITableViewCell.appearance().selectedBackgroundView = bgColorView
        UILabel.appearance().textColor = darkSecondary
        UITextView.appearance().textColor = darkSecondary
        UITextField.appearance().textColor = darkSecondary
        UITableViewCell.appearance().textLabel?.textColor = darkSecondary
        UINavigationBar.appearance().barTintColor = darkPrimary
        UINavigationBar.appearance().translucent = false
        View.appearance().backgroundColor = lightPrimary
        //        UITableViewCell.appearance().textLabel?.font = UIFont(name: primaryFont, size: 14)
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: headerFont, size: 24)!]
        UIBarButtonItem.appearance().setTitleTextAttributes(([NSFontAttributeName: UIFont(name: headerFont, size: 16)!]), forState: UIControlState.Normal)
        UITextField.appearance().font = UIFont(name: primaryFont, size: 16)
        UITextView.appearance().font = UIFont(name: primaryFont, size: 16)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

