//
//  ListData
//  Daily Three
//
//  Created by Mollie on 2/8/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

// like LibraryAPI.swift

import UIKit

private let _mainData: ListData = ListData()

class ListData: NSObject {
    
//    var selectedVenue: [String:AnyObject]?
////    var selectedDate
//    var selectedSeat: PFObject?
////    var selectedItem
//    var feedItems: [PFObject] = []
////    var myFeedItems: [PFObject] = []
    
    private let persistencyManager: PersistencyManager
    
    override init() {
        persistencyManager = PersistencyManager()
        
        super.init()
    }
    
    class func mainData() -> ListData {
        
        
        return _mainData
    }
    
    func getDateList() -> [DateData] {
        return persistencyManager.getDateList()
    }
    
    func addDate(dateData: DateData) {
        persistencyManager.addDate(dateData)
        // TODO: update NSUserDefaults
        // or should that be in PersistencyManager?
    }
    
    func deleteDate(index: Int) {
        persistencyManager.deleteDateAtIndex(index)
        // TODO: update NSUserDefaults
    }
   
}
