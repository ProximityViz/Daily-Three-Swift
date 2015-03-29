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
var listData = [DateData]()

class ItemsTVC: UITableViewController, LPRTableViewDelegate, UISplitViewControllerDelegate {
    
    private var listData = [DateData]()
    
    @IBOutlet var dataTable: LPRTableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        refresh()
        
    }
    
    func refresh() {
        
        listData = ListData.mainData().getDateList()
        
        setTitleText()
        
        showDataForDate(currentDateIndex)
        
        tableView.reloadData()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = lightPrimary
        // check that OS is >= 8
        if (splitViewController?.respondsToSelector("displayModeButtonItem") != nil) {
            navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        }
        navigationItem.leftItemsSupplementBackButton = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refresh", name: "viewDate", object: nil)
        
        navigationController?.navigationBar.translucent = false
        
        // set cell height
        let statusBarSize = UIApplication.sharedApplication().statusBarFrame.size
        let statusBarHeight = Swift.min(statusBarSize.width, statusBarSize.height)
        let navBarHeight:CGFloat = navigationController!.navigationBar.frame.height
        let barHeight = statusBarHeight + navBarHeight
        tableView.rowHeight = (view.frame.size.height - barHeight) / 3
        tableView.reloadData()
        
        currentItemIndex = 0
        
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
        
        splitViewController?.delegate = self
        
    }
    
    // when iPad is in portrait mode, always show both halves of splitview
    func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool {
        
        return false
    }
    
    func rotated() {
        
        setTitleText()
        
        // reset cell height
        tableView.rowHeight = tableView.frame.size.height / 3
        tableView.reloadData()
        
    }
    func setTitleText() {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d"
        if listData.isEmpty || currentDateIndex == -1 {
            title = "Your Three Items"
        } else if UIScreen.mainScreen().bounds.width < 480 {
            title = dateFormatter.stringFromDate(listData[currentDateIndex].unformattedDate)
        } else {
            title = listData[currentDateIndex].formattedDate
        }
        
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dateData = currentDateData {
            return dateData.titles.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // TODO: make sure that the number of lines for textLabel and detailTextLabel are correct and maximized
        cell.textLabel?.numberOfLines = 2
        // this next line is assuming textLabel font size of 18 and detailLabel of 14
        cell.detailTextLabel?.numberOfLines = Int(floor(CGFloat((cell.frame.height - 54) / 21)))
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        cell.textLabel?.font = UIFont(name: primaryFont, size: 18)
        cell.detailTextLabel?.font = UIFont(name: primaryFont, size: 14)
        
        if indexPath.row == 0 {
            cell.imageView?.image = UIImage(named: "Item 1")
        } else if indexPath.row == 1 {
            cell.imageView?.image = UIImage(named: "Item 2")
        } else if indexPath.row == 2 {
            cell.imageView?.image = UIImage(named: "Item 3")
        }
        
        cell.accessoryView?.frame = CGRectMake(0, 0, 31, 31)
        cell.frame.size.height = 100
        
        listData = ListData.mainData().getDateList()
        showDataForDate(currentDateIndex)
        
        if let dateData = currentDateData {
            
            if dateData.titles[indexPath.row] == "" {
                cell.textLabel?.text = "Daily Item #" + String(indexPath.row + 1)
                cell.textLabel?.textColor = darkPrimary
            } else {
                cell.textLabel?.text = dateData.titles[indexPath.row]
                cell.textLabel?.textColor = darkSecondary
            }
            
            if let detailTextLabel = cell.detailTextLabel {
                detailTextLabel.text = dateData.details[indexPath.row]
            }
            
            let done = dateData.done[indexPath.row]
            
            if done {
                cell.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
            } else {
                cell.accessoryView = UIImageView(image: UIImage(named: "Disclosure"))
            }
            
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        listData = ListData.mainData().getDateList()
        showDataForDate(currentDateIndex)
        currentItemIndex = indexPath.row
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var completeAction = UITableViewRowAction(style: .Normal, title: "☑") { (action, indexPath) -> Void in
            
            tableView.editing = false
            
            markItemDone(indexPath.row, currentDateIndex, tableView, indexPath)
            
        }
        
        return [completeAction]
        
    }
    
//    override func setEditing(editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        if let dateData = currentDateData {
            
            if (fromIndexPath.row == 0 && toIndexPath.row == 1) || (fromIndexPath.row == 1 && toIndexPath.row == 0) {
                // top & middle swap
                ListData.mainData().changeItemAtPosition("top", forDateIndex: currentDateIndex, withTitle: dateData.titles[1], withDetail: dateData.details[1], withDone: dateData.done[1])
                ListData.mainData().changeItemAtPosition("middle", forDateIndex: currentDateIndex, withTitle: dateData.titles[0], withDetail: dateData.details[0], withDone: dateData.done[0])
//                tableView.editing = false
            } else if (fromIndexPath.row == 1 && toIndexPath.row == 2) || (fromIndexPath.row == 2 && toIndexPath.row == 1) {
                // middle & bottom swap
                ListData.mainData().changeItemAtPosition("bottom", forDateIndex: currentDateIndex, withTitle: dateData.titles[1], withDetail: dateData.details[1], withDone: dateData.done[1])
                ListData.mainData().changeItemAtPosition("middle", forDateIndex: currentDateIndex, withTitle: dateData.titles[2], withDetail: dateData.details[2], withDone: dateData.done[2])
//                tableView.editing = false
            } else if fromIndexPath.row == 0 && toIndexPath.row == 2 {
                // what was top is now bottom
                ListData.mainData().changeItemAtPosition("bottom", forDateIndex: currentDateIndex, withTitle: dateData.titles[0], withDetail: dateData.details[0], withDone: dateData.done[0])
                // what was middle is now top
                ListData.mainData().changeItemAtPosition("top", forDateIndex: currentDateIndex, withTitle: dateData.titles[1], withDetail: dateData.details[1], withDone: dateData.done[1])
                // what was bottom is now middle
                ListData.mainData().changeItemAtPosition("middle", forDateIndex: currentDateIndex, withTitle: dateData.titles[2], withDetail: dateData.details[2], withDone: dateData.done[2])
//                tableView.editing = false
            } else if fromIndexPath.row == 2 && toIndexPath.row == 0 {
                // top becomes middle
                ListData.mainData().changeItemAtPosition("middle", forDateIndex: currentDateIndex, withTitle: dateData.titles[0], withDetail: dateData.details[0], withDone: dateData.done[0])
                // middle becomes bottom
                ListData.mainData().changeItemAtPosition("bottom", forDateIndex: currentDateIndex, withTitle: dateData.titles[1], withDetail: dateData.details[1], withDone: dateData.done[1])
                // bottom becomes top
                ListData.mainData().changeItemAtPosition("top", forDateIndex: currentDateIndex, withTitle: dateData.titles[2], withDetail: dateData.details[2], withDone: dateData.done[2])
//                tableView.editing = false
            }
            
        }
        
        tableView.reloadData()
        
    }
    
//    // Override to support conditional rearranging of the table view.
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the item to be re-orderable.
//        return true
//    }
    
}

extension ItemsTVC: UITableViewDelegate {
    
    
    
}
