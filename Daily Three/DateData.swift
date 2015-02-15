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
    func dde_tableRepresentation() -> (titles:[String], details:[String], done:[Bool]) {
        return ([topTitle, middleTitle, bottomTitle], [topDetail, middleDetail, bottomDetail], [topDone, middleDone, bottomDone])
    }
}

class DateData: NSObject {
    
    var done : Bool!
    var topTitle : String!
    var topDetail : String!
    var topDone : Bool!
    var middleTitle : String!
    var middleDetail : String!
    var middleDone : Bool!
    var bottomTitle : String!
    var bottomDetail : String!
    var bottomDone : Bool!
    var formattedDate : String!
    var unformattedDate : NSDate!
    
    required init(coder aDecoder: NSCoder) {
        done = aDecoder.decodeObjectForKey("done") as Bool
        topTitle = aDecoder.decodeObjectForKey("topTitle") as String
        topDetail = aDecoder.decodeObjectForKey("topDetail") as String
        topDone = aDecoder.decodeObjectForKey("topDone") as Bool
        middleTitle = aDecoder.decodeObjectForKey("middleTitle") as String
        middleDetail = aDecoder.decodeObjectForKey("middleDetail") as String
        middleDone = aDecoder.decodeObjectForKey("middleDone") as Bool
        bottomTitle = aDecoder.decodeObjectForKey("bottomTitle") as String
        bottomDetail = aDecoder.decodeObjectForKey("bottomDetail") as String
        bottomDone = aDecoder.decodeObjectForKey("bottomDone") as Bool
        formattedDate = aDecoder.decodeObjectForKey("formattedDate") as String
        unformattedDate = aDecoder.decodeObjectForKey("unformattedDate") as NSDate
    }
    
    override init() {
        super.init()
        
        done = false
        topTitle = ""
        topDetail = ""
        topDone = false
        middleTitle = ""
        middleDetail = ""
        middleDone = false
        bottomTitle = ""
        bottomDetail = ""
        bottomDone = false
        formattedDate = ""
        unformattedDate = NSDate()
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(done, forKey: "done")
        aCoder.encodeObject(topTitle, forKey: "topTitle")
        aCoder.encodeObject(topDetail, forKey: "topDetail")
        aCoder.encodeObject(topDone, forKey: "topDone")
        aCoder.encodeObject(middleTitle, forKey: "middleTitle")
        aCoder.encodeObject(middleDetail, forKey: "middleDetail")
        aCoder.encodeObject(middleDone, forKey: "middleDone")
        aCoder.encodeObject(bottomTitle, forKey: "bottomTitle")
        aCoder.encodeObject(bottomDetail, forKey: "bottomDetail")
        aCoder.encodeObject(bottomDone, forKey: "bottomDone")
        aCoder.encodeObject(formattedDate, forKey: "formattedDate")
        aCoder.encodeObject(unformattedDate, forKey: "unformattedDate")
    }
    
    required init(unformattedDate: NSDate) {
        super.init()
        
        self.done = false
        self.topTitle = "TitleA"
        self.topDetail = "DetailA"
        self.topDone = false
        self.middleTitle = "TitleB"
        self.middleDetail = "DetailB"
        self.middleDone = false
        self.bottomTitle = "TitleC"
        self.bottomDetail = "DetailC"
        self.bottomDone = false
        
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

