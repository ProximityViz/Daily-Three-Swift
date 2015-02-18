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
    
    func setDateList() {
        return persistencyManager.setDateList()
    }
    
    func addDate(dateData: DateData) {
        persistencyManager.addDate(dateData)
    }
    
    func deleteDate(index: Int) {
        persistencyManager.deleteDateAtIndex(index)
    }
    
    func changeItemAtPosition(position: String, forDateIndex date: Int, withTitle: String, withDetail: String, withDone: Bool) {
        
        if position == "top" {
            ListData.mainData().getDateList()[date].topTitle = withTitle
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[date].topDetail = withDetail
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[date].topDone = withDone
            ListData.mainData().setDateList()
        } else if position == "middle" {
            ListData.mainData().getDateList()[date].middleTitle = withTitle
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[date].middleDetail = withDetail
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[date].middleDone = withDone
            ListData.mainData().setDateList()
        } else {
            ListData.mainData().getDateList()[date].bottomTitle = withTitle
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[date].bottomDetail = withDetail
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[date].bottomDone = withDone
            ListData.mainData().setDateList()
        }
        
    }
    
}
