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
        
        navigationItem.rightBarButtonItem = editButtonItem()
        
        tableView.rowHeight = (view.frame.size.height - 63) / 3
        
        currentItemIndex = 0
        
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
        
        tableView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:"))
        
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
  
    func longPressGestureRecognized(sender: UILongPressGestureRecognizer) {
        
        let longPress = sender
        
        let state = sender.state
        
        let location = longPress.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(location)
        
        var snapshot = UIImageView()
        var sourceIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        
        switch state {
        
        case .Began:
        
            if (indexPath != nil) {
                sourceIndexPath = indexPath!
                
                if let cell = tableView.cellForRowAtIndexPath(indexPath!) {
                
                    snapshot = customSnapshotFromView(cell)
                    
                    snapshot.center = cell.center
                    snapshot.alpha = 0
                    
                    tableView.addSubview(snapshot)
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        
                        cell.center.y = location.y
                        snapshot.center = cell.center
                        snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05)
                        snapshot.alpha = 0.98
                        
                        cell.alpha = 0
                        
                    }, completion: { (finished) -> Void in
                        
                        cell.hidden = true
                        
                    })
                }
                
            }
            
        case .Changed:
            
            var center = snapshot.center
            center.y = location.y
            
            // is destination valid and different from source?
            if (indexPath != nil && indexPath != sourceIndexPath) {
                
                // update data source
                
                // move the rows
                tableView.moveRowAtIndexPath(sourceIndexPath, toIndexPath: indexPath!)
                
                // update sourceIndexPath
                sourceIndexPath = indexPath!
                
            }
            
        default:
            
            // clean up
            var cell:UITableViewCell = tableView.cellForRowAtIndexPath(sourceIndexPath)!
            cell.hidden = false
            cell.alpha = 0
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                
                snapshot.center = cell.center
                snapshot.transform = CGAffineTransformIdentity
                snapshot.alpha = 0
                
                cell.alpha = 1
                
            }, completion: { (finished) -> Void in
                
                sourceIndexPath = NSIndexPath()
                snapshot.removeFromSuperview()
                snapshot = UIImageView()
                
            })
            
        }
        
        
    }
    
    func customSnapshotFromView(inputView: UIView) -> UIImageView {
        
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let snapshot = UIImageView(image: image)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0
        snapshot.layer.shadowOffset = CGSizeMake(-5, 0)
        snapshot.layer.shadowRadius = 5
        snapshot.layer.shadowOpacity = 0.4
        
        return snapshot
    }

}

// TODO: why are these in an extension?
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
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
//    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//        if let dateData = currentDateData {
//            
//            if (fromIndexPath.row == 0 && toIndexPath.row == 1) || (fromIndexPath.row == 1 && toIndexPath.row == 0) {
//                // top & middle swap
//                ListData.mainData().changeItemAtPosition("top", forDateIndex: currentDateIndex, withTitle: dateData.titles[1], withDetail: dateData.details[1], withDone: dateData.done[1])
//                ListData.mainData().changeItemAtPosition("middle", forDateIndex: currentDateIndex, withTitle: dateData.titles[0], withDetail: dateData.details[0], withDone: dateData.done[0])
////                tableView.editing = false
//            } else if (fromIndexPath.row == 1 && toIndexPath.row == 2) || (fromIndexPath.row == 2 && toIndexPath.row == 1) {
//                // middle & bottom swap
//                ListData.mainData().changeItemAtPosition("bottom", forDateIndex: currentDateIndex, withTitle: dateData.titles[1], withDetail: dateData.details[1], withDone: dateData.done[1])
//                ListData.mainData().changeItemAtPosition("middle", forDateIndex: currentDateIndex, withTitle: dateData.titles[2], withDetail: dateData.details[2], withDone: dateData.done[2])
////                tableView.editing = false
//            } else if fromIndexPath.row == 0 && toIndexPath.row == 2 {
//                // what was top is now bottom
//                ListData.mainData().changeItemAtPosition("bottom", forDateIndex: currentDateIndex, withTitle: dateData.titles[0], withDetail: dateData.details[0], withDone: dateData.done[0])
//                // what was middle is now top
//                ListData.mainData().changeItemAtPosition("top", forDateIndex: currentDateIndex, withTitle: dateData.titles[1], withDetail: dateData.details[1], withDone: dateData.done[1])
//                // what was bottom is now middle
//                ListData.mainData().changeItemAtPosition("middle", forDateIndex: currentDateIndex, withTitle: dateData.titles[2], withDetail: dateData.details[2], withDone: dateData.done[2])
////                tableView.editing = false
//            } else if fromIndexPath.row == 2 && toIndexPath.row == 0 {
//                // top becomes middle
//                ListData.mainData().changeItemAtPosition("middle", forDateIndex: currentDateIndex, withTitle: dateData.titles[0], withDetail: dateData.details[0], withDone: dateData.done[0])
//                // middle becomes bottom
//                ListData.mainData().changeItemAtPosition("bottom", forDateIndex: currentDateIndex, withTitle: dateData.titles[1], withDetail: dateData.details[1], withDone: dateData.done[1])
//                // bottom becomes top
//                ListData.mainData().changeItemAtPosition("top", forDateIndex: currentDateIndex, withTitle: dateData.titles[2], withDetail: dateData.details[2], withDone: dateData.done[2])
////                tableView.editing = false
//            }
//            
//        }
//        
//    }
//    
//    // Override to support conditional rearranging of the table view.
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the item to be re-orderable.
//        return true
//    }
    
}

extension ItemsTVC: UITableViewDelegate {
    
    
    
}
