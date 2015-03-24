//
//  ItemsIC.swift
//  Daily Three
//
//  Created by Mollie on 3/23/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import WatchKit
import Foundation

class ItemsIC: WKInterfaceController {
    
    var toDoItems = ["List items", "Save data", "Notification"]
    var doneItems = [false, false, false]
    
    var listData = [DateData]()
    var currentDateData : (titles:[String], details:[String])?
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if defaults?.objectForKey("settings") != nil {
            let settings = defaults?.objectForKey("settings") as [String:AnyObject]
            println(settings)
        }

        listData = ListData.mainData().getDateList()
        println(listData.count)
        
        for date in listData {
            
            println(date.dde_tableRepresentation())
            println(date.formattedDate)
            
            // if currentDate equals the date of this date,
            // currentDateData = date.dde_tableRepresentation()
            // otherwise, currentDateData = [empty]
            
        }
        
        // get the object from listData that has a date of today
        // get that object's to-do list items and list them in the table
        // be able to mark items done
        
        loadTableData()
        
    }
    
    func loadTableData() {
        
        table.setNumberOfRows(toDoItems.count, withRowType: "itemsTRC")
        
        for (index, item) in enumerate(toDoItems) {
            
            let row = table.rowControllerAtIndex(index) as ItemsTRC
            row.itemTitleLabel.setText(item)
            if doneItems[index] {
                row.itemCompletedImage.setHidden(false)
//                row.itemTitleLabel.setWidth(100) // get it to change width to leave space for checkmark
            } else {
                row.itemCompletedImage.setHidden(true)
                // change width to full width
            }
            
        }
        
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        doneItems[rowIndex] = doneItems[rowIndex] ? false : true
        // save in Defaults
        // synchronize
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
    
}

