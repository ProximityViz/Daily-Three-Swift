//
//  DateData.swift
//  Daily Three
//
//  Created by Mollie on 2/13/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

// similar to Album.swift

import UIKit

extension DateData {
    // date data extension
    func dde_tableRepresentation() -> (titles:[String], details:[String]) {
        return ([topTitle, middleTitle, bottomTitle], [topDetail, middleDetail, bottomDetail])
    }
}

class DateData: NSObject {
    
    var topTitle : String!
    var topDetail : String!
    var middleTitle : String!
    var middleDetail : String!
    var bottomTitle : String!
    var bottomDetail : String!
    var formattedDate : String!
    var unformattedDate: NSDate!
    
    init(unformattedDate: NSDate) {
        super.init()
        
        // FIXME: Should this stuff move to PersistencyManager?
        // I don't think it should, but something needs to be handled differently
        self.topTitle = "Title"
        self.topDetail = "Detail"
        self.middleTitle = "Title"
        self.middleDetail = "Detail"
        self.bottomTitle = "Title"
        self.bottomDetail = "Detail"
        
        // format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        self.formattedDate = dateFormatter.stringFromDate(unformattedDate)
        
        self.unformattedDate = unformattedDate
    }
   
}
