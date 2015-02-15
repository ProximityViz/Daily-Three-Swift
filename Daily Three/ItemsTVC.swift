//
//  ItemsTVC.swift
//  Daily Three
//
//  Created by Mollie on 2/8/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

var currentItemIndex:Int!
var currentDateData : (titles:[String], details:[String], done:[Bool])?

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
        
        title = "List"
        
        tableView.rowHeight = (view.frame.size.height - 63) / 3
        
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

}

// why are these in an extension?
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
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.accessoryView?.frame = CGRectMake(0, 0, 44, 44)
        
        if let dateData = currentDateData {
            
            cell.textLabel?.text = dateData.titles[indexPath.row]
            
            if let detailTextLabel = cell.detailTextLabel {
                detailTextLabel.text = dateData.details[indexPath.row]
            }
            
            let done = dateData.done[indexPath.row]
            
            if done {
                cell.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
            } else {
                cell.accessoryView = UIImageView(image: UIImage(named: "Blank"))
            }
            
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        currentItemIndex = indexPath.row
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var completeAction = UITableViewRowAction(style: .Normal, title: "☑") { (action, indexPath) -> Void in
            
            tableView.editing = false
            
            switch indexPath.row {
                
            case 0:
                if (ListData.mainData().getDateList()[currentDateIndex].topDone == true) {
                    ListData.mainData().getDateList()[currentDateIndex].topDone = false
                    tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = UIImageView(image: UIImage(named: "Blank"))
                } else {
                    ListData.mainData().getDateList()[currentDateIndex].topDone = true
                    tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
                }
                
            case 1:
                if (ListData.mainData().getDateList()[currentDateIndex].middleDone == true) {
                    ListData.mainData().getDateList()[currentDateIndex].middleDone = false
                    tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = UIImageView(image: UIImage(named: "Blank"))
                } else {
                    ListData.mainData().getDateList()[currentDateIndex].middleDone = true
                    tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
                }
                
            default:
                if (ListData.mainData().getDateList()[currentDateIndex].bottomDone == true) {
                    ListData.mainData().getDateList()[currentDateIndex].bottomDone = false
                    tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = UIImageView(image: UIImage(named: "Blank"))
                } else {
                    ListData.mainData().getDateList()[currentDateIndex].bottomDone = true
                    tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
                }
                
                
            }
            
            ListData.mainData().setDateList()
            
        }
        
        return [completeAction]
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}

extension ItemsTVC: UITableViewDelegate {
    
    
    
}
