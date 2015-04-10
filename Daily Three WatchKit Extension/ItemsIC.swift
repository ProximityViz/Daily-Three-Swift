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
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if defaults?.objectForKey("settings") != nil {
            let settings = defaults?.objectForKey("settings") as! [String:AnyObject]
        }
        
        watchListData = ListData.mainData().getDateList()
        
        currentWatchDateData = getDataForDate(currentWatchDateIndex, watchListData)
        
        loadTableData()
        
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        loadTableData()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadTableData() {
        
        let (titles, details, done) = currentWatchDateData!
        
        table.setNumberOfRows(titles.count, withRowType: "itemsTRC")
        
        for (index, item) in enumerate(titles) {
            
            let row = table.rowControllerAtIndex(index) as! ItemsTRC
            row.itemTitleLabel.setText(item)
            if done[index] {
                row.itemCompletedImage.setHidden(false)
                if WKInterfaceDevice.currentDevice().screenBounds.width == 156 {
                    row.itemTitleLabel.setWidth(100)
                } else {
                    row.itemTitleLabel.setWidth(80)
                }
            } else {
                row.itemCompletedImage.setHidden(true)
                if WKInterfaceDevice.currentDevice().screenBounds.width == 156 {
                    row.itemTitleLabel.setWidth(150)
                } else { // 136
                    row.itemTitleLabel.setWidth(130)
                }
            }
            
        }
        
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        
        currentWatchItemIndex = rowIndex
        
        return nil
    }
    
    
}

