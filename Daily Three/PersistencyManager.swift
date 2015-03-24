//
//  PersistencyManager.swift
//  Daily Three
//
//  Created by Mollie on 2/13/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

let defaults = NSUserDefaults(suiteName: "group.com.proximityviz.dailyThreeGroup")

class PersistencyManager: NSObject {
    
    private var dateList = [DateData]()
    
    func getDateList() -> [DateData] {
        
        if defaults?.objectForKey("listData") == nil {
            // add DateData for today
            addDate(DateData(unformattedDate: NSDate()))
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
