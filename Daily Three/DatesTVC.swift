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
        super.viewWillAppear(true)
        
        listData = ListData.mainData().getDateList()
        
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitViewController?.preferredPrimaryColumnWidthFraction = 0.5 // FIXME: not working
        
        currentDateIndex = 0
        
        splitViewController?.view.backgroundColor = darkPrimary
        tableView.backgroundColor = lightPrimary
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.98, green:0.87, blue:0.57, alpha:1), NSFontAttributeName: UIFont(name: headerFont, size: 24)!]
        
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
        
        // format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        let today = dateFormatter.stringFromDate(NSDate())
        let yesterday = dateFormatter.stringFromDate(NSDate(timeIntervalSinceNow: -86400))
        let tomorrow = dateFormatter.stringFromDate(NSDate(timeIntervalSinceNow: 86400))
        
        // switch
        let formattedDate = listData[indexPath.row].formattedDate
        switch formattedDate {
        case today:
            cell.textLabel?.text = "Today, \(removeDayOfWeek(formattedDate))"
        case yesterday:
            cell.textLabel?.text = "Yesterday, \(removeDayOfWeek(formattedDate))"
        case tomorrow:
            cell.textLabel?.text = "Tomorrow, \(removeDayOfWeek(formattedDate))"
        default:
            cell.textLabel?.text = formattedDate
        }
        
        cell.accessoryView?.frame = CGRectMake(0, 0, 31, 31)
        if listData[indexPath.row].done == true {
            cell.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
        } else {
            cell.accessoryView = UIImageView(image: UIImage(named: "Disclosure"))
        }
        
        cell.textLabel?.font = UIFont(name: primaryFont, size: 20)
        
        var bgColorView = UIView()
        bgColorView.backgroundColor = mediumPrimary
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 43
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        currentDateIndex = indexPath.row
        NSNotificationCenter.defaultCenter().postNotificationName("viewDate", object: currentDateIndex) // reload tableview of ItemsTVC
        
        let navC = storyboard?.instantiateViewControllerWithIdentifier("itemsNavC") as UINavigationController
        showDetailViewController(navC, sender: self)
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (action, indexPath) -> Void in
            
            tableView.editing = false
            
            ListData.mainData().deleteDate(indexPath.row)
            self.listData = ListData.mainData().getDateList()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
        var completeAction = UITableViewRowAction(style: .Normal, title: "☑") { (action, indexPath) -> Void in
            
            tableView.editing = false
            
            if ListData.mainData().getDateList()[indexPath.row].done == true {
                ListData.mainData().getDateList()[indexPath.row].done = false
                tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = UIImageView(image: UIImage(named: "Blank"))
            } else {
                ListData.mainData().getDateList()[indexPath.row].done = true
                tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
            }
            
            ListData.mainData().setDateList()
            
        }
        
        return [deleteAction, completeAction]
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // convert "Sunday, February 22" to "February 22"
    func removeDayOfWeek(formattedDate: String) -> String {
        
        let dateInfo = formattedDate as String
        let dateArray = dateInfo.componentsSeparatedByString(", ")
        let date = dateArray[1]
        
        return date
    }

}
