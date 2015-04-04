//
//  GlanceController.swift
//  Daily Three WatchKit Extension
//
//  Created by Mollie on 3/23/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import WatchKit
import Foundation
import UIKit

class GlanceTRC: NSObject {
    
    @IBOutlet weak var itemTitleLabel: WKInterfaceLabel!
    @IBOutlet weak var itemCompletedImage: WKInterfaceImage!
    
}

// similar to ItemsIC but always grabs today
// TODO: refactor & combine code with ItemsIC

class GlanceController: WKInterfaceController {
    
    var toDoItems = ["List items", "Save data", "Notification"]
    var doneItems = [false, false, false]
    
    var listData = [DateData]()
    var currentDateData : (titles:[String], details:[String], done:[Bool])!
    var currentDateIndex = 0
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if defaults?.objectForKey("settings") != nil {
            let settings = defaults?.objectForKey("settings") as [String:AnyObject]
        }
        
        findDateInData()
        
        // handle what should happen if today doesn't have any data
        if currentDateData == nil {
            
            ListData.mainData().addDate(DateData(unformattedDate: NSDate()))
            // run again so index is correct
            findDateInData()
            
        }
        
    }
    
    func findDateInData() {
        
        listData = ListData.mainData().getDateList()
        
        currentDateIndex = 0
        
        for date in listData {
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM d"
            let today = dateFormatter.stringFromDate(NSDate())
            
            let yearFormatter = NSDateFormatter()
            yearFormatter.dateFormat = "yyyy"
            
            // see if year and date are the same
            if today == date.formattedDate && yearFormatter.stringFromDate(NSDate()) == yearFormatter.stringFromDate(date.unformattedDate) {
                currentDateData = date.dde_tableRepresentation()
                loadTableData()
                break
            }
            
            currentDateIndex++
            
        }
        
    }
    
    func loadTableData() {
        
        let (titles, details, done) = currentDateData!
        
        table.setNumberOfRows(titles.count, withRowType: "glanceTRC")
        
        for (index, item) in enumerate(titles) {
            
            let row = table.rowControllerAtIndex(index) as GlanceTRC
            row.itemTitleLabel.setText(item)
            if done[index] {
                row.itemCompletedImage.setHidden(false)
                row.itemTitleLabel.setWidth(110)
            } else {
                row.itemCompletedImage.setHidden(true)
                row.itemTitleLabel.setWidth(150)
            }
            
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
