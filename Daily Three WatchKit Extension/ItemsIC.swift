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
    var currentDateData : (titles:[String], details:[String], done:[Bool])!
    var currentDateIndex = 0
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if defaults?.objectForKey("settings") != nil {
            let settings = defaults?.objectForKey("settings") as [String:AnyObject]
            println(settings)
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
        
        println("find date")
        
        currentDateIndex = 0
        
        for date in listData {
            // FIXME: what if it's the same weekday, day, and month, but a different year?
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEEE, MMMM d"
            let today = formatter.stringFromDate(NSDate())
            
            if today == date.formattedDate {
                currentDateData = date.dde_tableRepresentation()
                println("today")
                loadTableData()
                break
            }
            
            currentDateIndex++
            
        }
        
    }
    
    func loadTableData() {
        
        let (titles, details, done) = currentDateData!
        
        table.setNumberOfRows(titles.count, withRowType: "itemsTRC")
        
        for (index, item) in enumerate(titles) {
            
            let row = table.rowControllerAtIndex(index) as ItemsTRC
            row.itemTitleLabel.setText(item)
            if done[index] {
                row.itemCompletedImage.setHidden(false)
//                row.itemTitleLabel.setWidth(100) // get it to change width to leave space for checkmark
            } else {
                row.itemCompletedImage.setHidden(true)
                // change width to full width
            }
            
        }
        
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        currentDateData.done[rowIndex] = currentDateData.done[rowIndex] ? false : true
        
        markItemDone(rowIndex, currentDateIndex, nil, nil)
        
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

