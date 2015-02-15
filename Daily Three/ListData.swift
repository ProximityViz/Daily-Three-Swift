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
   
}
