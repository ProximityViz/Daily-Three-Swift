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
    
    var toDoItems = ["item 1", "item 2", "item 3"]
    var doneItems = [false, false, false]
    
    var defaults = NSUserDefaults(suiteName: "group.com.proximityviz.dailyThreeGroup")
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if defaults?.objectForKey("settings") != nil {
            let settings = defaults?.objectForKey("settings") as [String:AnyObject]
            println(settings)
        }
        
        //        if let unarchivedObject = defaults?.objectForKey("listData") as? NSData {
        //
        //            return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [DateData]
        //
        //        }
        
        loadTableData()
        
    }
    
    func loadTableData() {
        
        table.setNumberOfRows(toDoItems.count, withRowType: "itemsTRC")
        
        for (index, item) in enumerate(toDoItems) {
            
            let row = table.rowControllerAtIndex(index) as ItemsTRC
            row.itemTitleLabel.setText(item)
            if doneItems[index] {
                row.itemCompletedImage.setHidden(false)
            } else {
                row.itemCompletedImage.setHidden(true)
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

