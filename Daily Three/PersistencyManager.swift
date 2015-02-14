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
        
        dateList = retrieveDates()!
        
        return dateList
    }
    
    func addDate(dateData: DateData) {
        dateList.append(dateData)
        for date in dateList {
            println(date.unformattedDate)
        }
        // TODO: make sure data stays with date
        dateList.sort({ $0.unformattedDate.timeIntervalSinceNow > $1.unformattedDate.timeIntervalSinceNow })
        
        saveDates(dateList)
    }
    
    func deleteDateAtIndex(index: Int) {
        dateList.removeAtIndex(index)
        
        saveDates(dateList)
    }
   
}
