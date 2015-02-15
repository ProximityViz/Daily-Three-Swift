//
//  PersistencyManager.swift
//  Daily Three
//
//  Created by Mollie on 2/13/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

let defaults = NSUserDefaults.standardUserDefaults()

class PersistencyManager: NSObject {
    
    private var dateList = [DateData]()
    
    func getDateList() -> [DateData] {
        
        if NSUserDefaults.standardUserDefaults().objectForKey("listData") != nil {
            dateList = retrieveDates()!
            return dateList
        } else {
            return []
        }
        
    }
    
    func setDateList() {
        
        saveDates(dateList)
        
    }
    
    func addDate(dateData: DateData) {
        dateList.append(dateData)
        for date in dateList {
            println(date.unformattedDate)
        }
        dateList.sort({ $0.unformattedDate.timeIntervalSinceNow > $1.unformattedDate.timeIntervalSinceNow })
        
        saveDates(dateList)
    }
    
    func deleteDateAtIndex(index: Int) {
        dateList.removeAtIndex(index)
        
        saveDates(dateList)
    }
   
}
