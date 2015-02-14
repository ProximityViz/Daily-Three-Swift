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
    
    required init(coder aDecoder: NSCoder) {
        topTitle = aDecoder.decodeObjectForKey("topTitle") as String
        topDetail = aDecoder.decodeObjectForKey("topDetail") as String
        middleTitle = aDecoder.decodeObjectForKey("middleTitle") as String
        middleDetail = aDecoder.decodeObjectForKey("middleDetail") as String
        bottomTitle = aDecoder.decodeObjectForKey("bottomTitle") as String
        bottomDetail = aDecoder.decodeObjectForKey("bottomDetail") as String
        formattedDate = aDecoder.decodeObjectForKey("formattedDate") as String
        unformattedDate = aDecoder.decodeObjectForKey("unformattedDate") as NSDate
    }
    
    override init() {
        super.init()
        
        topTitle = ""
        topDetail = ""
        middleTitle = ""
        middleDetail = ""
        bottomTitle = ""
        bottomDetail = ""
        formattedDate = ""
        unformattedDate = NSDate()
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(topTitle, forKey: "topTitle")
        aCoder.encodeObject(topDetail, forKey: "topDetail")
        aCoder.encodeObject(middleTitle, forKey: "middleTitle")
        aCoder.encodeObject(middleDetail, forKey: "middleDetail")
        aCoder.encodeObject(bottomTitle, forKey: "bottomTitle")
        aCoder.encodeObject(bottomDetail, forKey: "bottomDetail")
        aCoder.encodeObject(formattedDate, forKey: "formattedDate")
        aCoder.encodeObject(unformattedDate, forKey: "unformattedDate")
    }
    
    required init(unformattedDate: NSDate) {
        super.init()
        
        // FIXME: Should this stuff move to PersistencyManager?
        // I don't think it should, but something needs to be handled differently
        self.topTitle = "TitleA"
        self.topDetail = "DetailA"
        self.middleTitle = "TitleB"
        self.middleDetail = "DetailB"
        self.bottomTitle = "TitleC"
        self.bottomDetail = "DetailC"
        
        // format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        self.formattedDate = dateFormatter.stringFromDate(unformattedDate)
        
        self.unformattedDate = unformattedDate
        
    }
   
}

func saveDates(dates: [DateData]) {
    
    let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(dates as NSArray)
    defaults.setObject(archivedObject, forKey: "listData")
    defaults.synchronize()
    
}

func retrieveDates() -> [DateData]? {
    
    if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey("listData") as? NSData {
        
        return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [DateData]
        
    }
    
    return nil
    
}

