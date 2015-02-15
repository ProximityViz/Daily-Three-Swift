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
    
    func changeItemAtPosition(position: String, forDateIndex: Int, withTitle: String, withDetail: String, withDone: Bool) {
        
        if position == "top" {
            ListData.mainData().getDateList()[forDateIndex].topTitle = withTitle
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[forDateIndex].topDetail = withDetail
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[forDateIndex].topDone = withDone
            ListData.mainData().setDateList()
        } else if position == "middle" {
            ListData.mainData().getDateList()[forDateIndex].middleTitle = withTitle
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[forDateIndex].middleDetail = withDetail
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[forDateIndex].middleDone = withDone
            ListData.mainData().setDateList()
        } else {
            ListData.mainData().getDateList()[forDateIndex].bottomTitle = withTitle
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[forDateIndex].bottomDetail = withDetail
            ListData.mainData().setDateList()
            ListData.mainData().getDateList()[forDateIndex].bottomDone = withDone
            ListData.mainData().setDateList()
        }
        
    }
   
}
