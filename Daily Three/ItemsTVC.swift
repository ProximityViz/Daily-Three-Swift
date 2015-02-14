//
//  ItemsTVC.swift
//  Daily Three
//
//  Created by Mollie on 2/8/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class ItemsTVC: UITableViewController {
    
    private var listData = [DateData]()
    private var currentDateData : (titles:[String], details:[String])?
    private var currentDateIndex = 0
    private var currentItemIndex = 0

    @IBOutlet var dataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FIXME: this code is from a tutorial and may not be what I want
        self.navigationController?.navigationBar.translucent = false
        
        currentItemIndex = 0
        
        listData = ListData.mainData().getDateList()
        
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
        view.addSubview(dataTable!)
        
        self.showDataForItem(currentItemIndex)
    }
    
    func showDataForItem(itemIndex: Int) {
        // defensive
        if (itemIndex < listData.count && itemIndex > -1) {
            let item = listData[itemIndex]
            currentDateData = item.dde_tableRepresentation()
        } else {
            currentDateData = nil
        }
        dataTable!.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
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
    
}

extension ItemsTVC: UITableViewDelegate {
    
    
    
}
