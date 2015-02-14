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
        return dateList
    }
    
    func addDate(dateData: DateData) {
        dateList.append(dateData)
        // TODO: sort
    }
    
    func deleteDateAtIndex(index: Int) {
        dateList.removeAtIndex(index)
    }
   
}
