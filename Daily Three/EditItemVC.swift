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
    
    @IBOutlet weak var detailBottomConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dateData = currentDateData {
            itemTitle.text = dateData.titles[currentItemIndex]
            itemDetail.text = dateData.details[currentItemIndex]
        }
        
        title = "Edit"
        
        navigationController?.navigationBar.translucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("saveItem"))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: boldFont, size: 16)!], forState: UIControlState.Normal)
        
        itemTitle.autocapitalizationType = UITextAutocapitalizationType.Sentences
        itemDetail.autocapitalizationType = UITextAutocapitalizationType.Sentences

        itemTitle.layer.borderWidth = 1
        itemTitle.layer.borderColor = UIColor(red:0.75, green:0.28, blue:0.04, alpha:1).CGColor
        itemTitle.layer.cornerRadius = 5
        itemTitle.clipsToBounds = true
        itemDetail.layer.borderWidth = 1
        itemDetail.layer.borderColor = UIColor(red:0.75, green:0.28, blue:0.04, alpha:1).CGColor
        itemDetail.layer.cornerRadius = 5
        itemDetail.clipsToBounds = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                detailBottomConstraint.constant = keyboardSize.height + 16
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        detailBottomConstraint.constant = 16
    }
    
    // minimize keyboard on tap outside
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    func saveItem() {
        
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
        navigationController?.popViewControllerAnimated(true)
        
    }

}
