//
//  EditItemVC.swift
//  Daily Three
//
//  Created by Mollie on 2/8/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class EditItemVC: UIViewController {

    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemDetail: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if let dateData = currentDateData {
            itemTitle.text = dateData.titles[currentItemIndex]
            itemDetail.text = dateData.details[currentItemIndex]
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("saveItem"))

        itemDetail.layer.borderWidth = 1
        itemDetail.layer.borderColor = UIColor(red:0.9, green:0.9, blue:0.9, alpha:1).CGColor
        itemDetail.layer.cornerRadius = 5
        itemDetail.clipsToBounds = true
    }
    
    func saveItem() {
        println("item saved")
        
        // edit DateData
        let dateData = ListData.mainData().getDateList()[currentDateIndex]
        
        if currentItemIndex == 0 {
            dateData.topTitle = itemTitle.text
            dateData.topDetail = itemDetail.text
        } else if currentItemIndex == 1 {
            dateData.middleTitle = itemTitle.text
            dateData.middleDetail = itemDetail.text
        } else {
            dateData.bottomTitle = itemTitle.text
            dateData.bottomDetail = itemDetail.text
        }
        
        // remove old DateData
        ListData.mainData().deleteDate(currentDateIndex)
        
        // add new DateData
        ListData.mainData().addDate(dateData)
        
        // dismiss VC
        // FIXME: should there be a completion block?
        navigationController?.popViewControllerAnimated(true)
        
    }

}
