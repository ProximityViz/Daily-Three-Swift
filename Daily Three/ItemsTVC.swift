//
//  ItemsTVC.swift
//  Daily Three
//
//  Created by Mollie on 2/8/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

var currentItemIndex:Int!
var currentDateData : (titles:[String], details:[String])?

class ItemsTVC: UITableViewController {
    
    private var listData = [DateData]()
    
    @IBOutlet var dataTable: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        listData = ListData.mainData().getDateList()
        
        self.showDataForDate(currentDateIndex)
        
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FIXME: this code is from a tutorial and may not be what I want
        self.navigationController?.navigationBar.translucent = false
        
        currentItemIndex = 0
        
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
    }
    
    func showDataForDate(dateIndex: Int) {
        // defensive
        if (dateIndex < listData.count && dateIndex > -1) {
            let date = listData[dateIndex]
            currentDateData = date.dde_tableRepresentation()
        } else {
            currentDateData = nil
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

}

extension ItemsTVC: UITableViewDataSource {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dateData = currentDateData {
            return dateData.titles.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        if let dateData = currentDateData {
            cell.textLabel?.text = dateData.titles[indexPath.row]
            if let detailTextLabel = cell.detailTextLabel {
                detailTextLabel.text = dateData.details[indexPath.row]
            }
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        currentItemIndex = indexPath.row
        
    }
    
}

extension ItemsTVC: UITableViewDelegate {
    
    
    
}
