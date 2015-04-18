//
//  PersistencyManager.swift
//  Daily Three
//
//  Created by Mollie on 2/13/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class PersistencyManager: NSObject {
    
    private var dateList = [DateData]()
    
    func getDateList() -> [DateData] {
        
        if defaults?.objectForKey("listData") == nil {
            
            // check defaults from version 1.2 and earlier
            let oldDefaults = NSUserDefaults.standardUserDefaults()
            
            if let unarchivedObject = oldDefaults.objectForKey("listData") as? NSData {
                dateList = (NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [DateData])!
                // save to new defaults
                saveDates(dateList)
                
            } else {
                // if both standardUserDefaults and app group defaults are empty, add DateData for today
                addDate(DateData(unformattedDate: NSDate()))
            }
            
        }
        dateList = retrieveDates()!
        return dateList
        
    }
    
    func setDateList() {
        
        saveDates(dateList)
        
    }
    
    func addDate(dateData: DateData) {
        dateList.append(dateData)
        dateList.sort({ $0.unformattedDate.timeIntervalSinceNow > $1.unformattedDate.timeIntervalSinceNow })
        
        saveDates(dateList)
    }
    
    func deleteDateAtIndex(index: Int) {
        dateList.removeAtIndex(index)
        
        saveDates(dateList)
    }
   
}
