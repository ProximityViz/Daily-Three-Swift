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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("saveDate"))

    }
    
    func saveDate() {

//         create DateData with datePicker.date
//        ListData.mainData().addDate(datePicker.date)
        
        //        DateData.new()
        var temp = DateData(unformattedDate: datePicker.date)
        // does this need to be added to ListData or will it do that automatically?
        ListData.mainData().addDate(temp)
        
        // dismiss VC
        // FIXME: should there be a completion block?
        navigationController?.popViewControllerAnimated(true)
        
    }

}
