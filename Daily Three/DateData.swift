//
//  DateData.swift
//  Daily Three
//
//  Created by Mollie on 2/13/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

let defaults = NSUserDefaults(suiteName: "group.com.proximityviz.Daily-Three-Group")

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
        done = aDecoder.decodeObjectForKey("done") as! Bool
        topTitle = aDecoder.decodeObjectForKey("topTitle") as! String
        topDetail = aDecoder.decodeObjectForKey("topDetail") as! String
        topDone = aDecoder.decodeObjectForKey("topDone") as! Bool
        middleTitle = aDecoder.decodeObjectForKey("middleTitle") as! String
        middleDetail = aDecoder.decodeObjectForKey("middleDetail") as! String
        middleDone = aDecoder.decodeObjectForKey("middleDone") as! Bool
        bottomTitle = aDecoder.decodeObjectForKey("bottomTitle") as! String
        bottomDetail = aDecoder.decodeObjectForKey("bottomDetail") as! String
        bottomDone = aDecoder.decodeObjectForKey("bottomDone") as! Bool
        formattedDate = aDecoder.decodeObjectForKey("formattedDate") as! String
        unformattedDate = aDecoder.decodeObjectForKey("unformattedDate") as! NSDate
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
        self.topTitle = ""
        self.topDetail = ""
        self.topDone = false
        self.middleTitle = ""
        self.middleDetail = ""
        self.middleDone = false
        self.bottomTitle = ""
        self.bottomDetail = ""
        self.bottomDone = false
        
        // format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        self.formattedDate = dateFormatter.stringFromDate(unformattedDate)
        
        self.unformattedDate = unformattedDate
        
    }
   
}

func saveDates(dates: [DateData]) {
    
    // this line needs to be included before archiving or unarchiving when using WatchKit
    NSKeyedArchiver.setClassName("DateData", forClass: DateData.self)
    
    let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(dates as NSArray)
    defaults?.setObject(archivedObject, forKey: "listData")
    defaults?.synchronize()
    
}

func retrieveDates() -> [DateData]? {
    
    if let unarchivedObject = defaults?.objectForKey("listData") as? NSData {
        
        // this line needs to be included before archiving or unarchiving when using WatchKit
        NSKeyedUnarchiver.setClass(DateData.self, forClassName: "DateData")
        
        return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [DateData]
        
    }
    
    return nil
    
}

func getDataForDate(dateIndex: Int, listData: [DateData]) -> (titles:[String], details:[String], done:[Bool]) {
    
    // defensive
    if (dateIndex < listData.count && dateIndex > -1) {
        let date = listData[dateIndex]
        return date.dde_tableRepresentation()
    } else {
        return ([],[],[])
    }
}

func markItemDone(index: Int, currentDateIndex: Int, tableView: UITableView?, indexPath: NSIndexPath?) {
    
    switch index {
        
    case 0:
        if (ListData.mainData().getDateList()[currentDateIndex].topDone == true) {
            ListData.mainData().getDateList()[currentDateIndex].topDone = false
            tableView?.cellForRowAtIndexPath(indexPath!)?.accessoryView = UIImageView(image: UIImage(named: "Blank"))
        } else {
            ListData.mainData().getDateList()[currentDateIndex].topDone = true
            tableView?.cellForRowAtIndexPath(indexPath!)?.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
        }
        
    case 1:
        if (ListData.mainData().getDateList()[currentDateIndex].middleDone == true) {
            ListData.mainData().getDateList()[currentDateIndex].middleDone = false
            tableView?.cellForRowAtIndexPath(indexPath!)?.accessoryView = UIImageView(image: UIImage(named: "Blank"))
        } else {
            ListData.mainData().getDateList()[currentDateIndex].middleDone = true
            tableView?.cellForRowAtIndexPath(indexPath!)?.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
        }
        
    default:
        if (ListData.mainData().getDateList()[currentDateIndex].bottomDone == true) {
            ListData.mainData().getDateList()[currentDateIndex].bottomDone = false
            tableView?.cellForRowAtIndexPath(indexPath!)?.accessoryView = UIImageView(image: UIImage(named: "Blank"))
        } else {
            ListData.mainData().getDateList()[currentDateIndex].bottomDone = true
            tableView?.cellForRowAtIndexPath(indexPath!)?.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
        }
        
        
    }
    
    ListData.mainData().setDateList()
    
}

// convert "Sunday, February 22" to "February 22"
func removeDayOfWeek(formattedDate: String) -> String {
    
    let dateInfo = formattedDate as String
    let dateArray = dateInfo.componentsSeparatedByString(", ")
    let date = dateArray[1]
    
    return date
}

