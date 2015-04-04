//
//  ItemIC.swift
//  Daily Three
//
//  Created by Mollie on 3/29/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import WatchKit
import Foundation


class ItemIC: WKInterfaceController {

    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var detailLabel: WKInterfaceLabel!
    @IBOutlet weak var itemCompleteSwitch: WKInterfaceSwitch!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let dateData = currentWatchDateData {
            titleLabel.setText(dateData.titles[currentWatchItemIndex])
            detailLabel.setText(dateData.details[currentWatchItemIndex])
            itemCompleteSwitch.setOn(dateData.done[currentWatchItemIndex])
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func completeTask(value: Bool) {
        
        currentWatchDateData.done[currentWatchItemIndex] = currentWatchDateData.done[currentWatchItemIndex] ? false : true
        markItemDone(currentWatchItemIndex, currentWatchDateIndex, nil, nil)
        
    }

}
