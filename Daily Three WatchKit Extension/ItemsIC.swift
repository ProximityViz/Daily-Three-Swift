//
//  ItemsIC.swift
//  Daily Three
//
//  Created by Mollie on 3/23/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import WatchKit
import Foundation

class ItemsTRC: NSObject {
    
    @IBOutlet weak var itemTitleLabel: WKInterfaceLabel!
    @IBOutlet weak var itemCompletedImage: WKInterfaceImage!
    
}

class ItemsIC: WKInterfaceController {
    
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
        
        listData = ListData.mainData().getDateList()
        
        currentDateData = getDataForDate(currentWatchDateIndex, listData)
        
        loadTableData()
        
    }
    
    func loadTableData() {
        
        let (titles, details, done) = currentDateData!
        
        table.setNumberOfRows(titles.count, withRowType: "itemsTRC")
        
        for (index, item) in enumerate(titles) {
            
            let row = table.rowControllerAtIndex(index) as ItemsTRC
            row.itemTitleLabel.setText(item)
            if done[index] {
                row.itemCompletedImage.setHidden(false)
                row.itemTitleLabel.setWidth(100)
            } else {
                row.itemCompletedImage.setHidden(true)
                row.itemTitleLabel.setWidth(150)
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

