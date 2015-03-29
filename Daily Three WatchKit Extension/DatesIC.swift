//
//  DatesIC.swift
//  Daily Three
//
//  Created by Mollie on 3/29/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import WatchKit
import Foundation

var currentWatchDateIndex = 0

class DatesTRC: NSObject {
    
    @IBOutlet weak var dateTitleLabel: WKInterfaceLabel!
    
}

class DatesIC: WKInterfaceController {
    
    var listData = [DateData]()
    
    @IBOutlet weak var table: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        listData = ListData.mainData().getDateList()
        
        loadTableData()
        
    }
    
    func loadTableData() {
        
        table.setNumberOfRows(listData.count, withRowType: "datesTRC")
        
        for (index, item) in enumerate(listData) {
            
            // add today, tomorrow, yesterday code
            
            let row = table.rowControllerAtIndex(index) as DatesTRC
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEE, MMM d"
            row.dateTitleLabel.setText(dateFormatter.stringFromDate(item.unformattedDate))
            
        }
        
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        
        currentWatchDateIndex = rowIndex
        
        return nil
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
