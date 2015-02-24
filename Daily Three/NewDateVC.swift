//
//  NewDateVC.swift
//  Daily Three
//
//  Created by Mollie on 2/8/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

// like ViewController.swift

import UIKit

class NewDateVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Date"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("saveDate"))

    }
    
    func saveDate() {

        ListData.mainData().addDate(DateData(unformattedDate: datePicker.date))
        
        // dismiss VC
        navigationController?.popViewControllerAnimated(true)
        
    }

}
