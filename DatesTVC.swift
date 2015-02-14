//
//  DatesTVC.swift
//  Daily Three
//
//  Created by Mollie on 2/8/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

var currentDateIndex = 0

class DatesTVC: UITableViewController {
    
    private var listData = [DateData]()
    private var currentDateData : (titles:[String], details:[String])?
    
    @IBOutlet var dataTable: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        
        listData = ListData.mainData().getDateList()
        
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FIXME: this code is from a tutorial and may not be what I want
        self.navigationController?.navigationBar.translucent = false
        
        currentDateIndex = 0
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = listData[indexPath.row].formattedDate

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        currentDateIndex = indexPath.row
        
    }

}
