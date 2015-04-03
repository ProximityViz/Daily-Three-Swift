//
//  DatesIC.swift
//  Daily Three
//
//  Created by Mollie on 3/29/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import WatchKit
import Foundation

var watchListData = [DateData]()
var currentWatchDateData : (titles:[String], details:[String], done:[Bool])!
var currentWatchDateIndex = 0
var currentWatchItemIndex = 0

class DatesTRC: NSObject {
    
    @IBOutlet weak var dateTitleLabel: WKInterfaceLabel!
    
}

class DatesIC: WKInterfaceController {
    
    var watchListData = [DateData]()
    var todayDateIndex = 0
    var tomorrowDateIndex = 0
    
    @IBOutlet weak var table: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        watchListData = ListData.mainData().getDateList()
        
        loadTableData()
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadTableData() {
        
        table.setNumberOfRows(watchListData.count, withRowType: "datesTRC")
        
        for (index, item) in enumerate(watchListData) {
            
            let row = table.rowControllerAtIndex(index) as DatesTRC
            
            // label Today, Yesterday, Tomorrow
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM d"
            
            let today = dateFormatter.stringFromDate(NSDate())
            let yesterday = dateFormatter.stringFromDate(NSDate(timeIntervalSinceNow: -86400))
            let tomorrow = dateFormatter.stringFromDate(NSDate(timeIntervalSinceNow: 86400))
            
            let yearFormatter = NSDateFormatter()
            yearFormatter.dateFormat = "yyyy"
            
            let formattedDate = item.formattedDate
            let formattedYear = yearFormatter.stringFromDate(item.unformattedDate)
            // see if year and date are the same
            if yearFormatter.stringFromDate(NSDate()) == formattedYear {
                
                switch formattedDate {
                case today:
                    row.dateTitleLabel.setText("Today, \(removeDayOfWeek(formattedDate))")
                    println(item)
                    todayDateIndex = index
                case yesterday:
                    row.dateTitleLabel.setText("Yesterday, \(removeDayOfWeek(formattedDate))")
                case tomorrow:
                    row.dateTitleLabel.setText("Tomorrow, \(removeDayOfWeek(formattedDate))")
                    tomorrowDateIndex = index
                default:
                    row.dateTitleLabel.setText(formattedDate)
                }
                
            } else {
                row.dateTitleLabel.setText("\(formattedDate), \(formattedYear)")
            }
            
        }
        
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        
        currentWatchDateIndex = rowIndex
        
        return nil
    }
    
    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
        
        // only send them to today or tomorrow if that day has data
        if identifier == "goToToday" {
            println("today")
            currentWatchDateIndex = todayDateIndex
            pushControllerWithName("ItemsIC", context: nil)
        } else if identifier == "goToTomorrow" {
            println("tomorrow")
            currentWatchDateIndex = tomorrowDateIndex
            pushControllerWithName("ItemsIC", context: nil)
        }
        
    }

}
