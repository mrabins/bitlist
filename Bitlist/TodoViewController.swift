//
//  TodoViewController.swift
//  Bitlist
//
//  Created by Mark Rabins on 7/4/16.
//  Copyright © 2016 self.edu. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var completeButton: UIBarButtonItem!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var todo: TodoModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        print(todo)
        
        completeButton.title = "Complete"
        completeButton.tintColor = UIColor.blackColor()
        
        favoriteButton.title = "Favorite"
        favoriteButton.tintColor = UIColor.blackColor()
        
        deleteButton.title = "Delete"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        if todo.completed {
            navigationItem.leftBarButtonItem?.title = "Pending"
        }
        
        navigationItem.title = todo.title
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func completeButtonPressed(sender: UIBarButtonItem) {
        
    }
    
    @IBAction func favoriteButtonPressed (sender: UIBarButtonItem) {
        
    }
    
    @IBAction func deleteButtonPressed(sender: UIBarButtonItem) {
        
    }
    
    // UITableViewDataSource and UITableViewDelegate Functions
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        let timeStringFormatter = NSDateFormatter()
        timeStringFormatter.dateFormat = "HH:mm:ss"
        
        if indexPath.section == 0 {
            
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!
            
            if indexPath.row == 0 {
                cell.imageView?.image = UIImage(named: "calendar")
                
                if let dueDate = todo.dueDate {
                    
                    let dateString = dateStringFormatter.stringFromDate(dueDate)
                    cell.textLabel?.text = "Due " + dateString
                    cell.textLabel?.textColor = UIColor.blueColor()
                    cell.textLabel?.font = UIFont.boldSystemFontOfSize(17.0)
                } else {
                    cell.textLabel?.text = "Due Date"
                    cell.textLabel?.textColor = UIColor.lightGrayColor()
                }
            } else {
                cell.imageView?.image = UIImage(named: "repeat")
                if let repeatFrequency = todo.repeated {
                    cell.textLabel?.text = "Repeat \(repeatFrequency)"
                    cell.textLabel?.textColor = UIColor.blueColor()
                    cell.textLabel?.font = UIFont.boldSystemFontOfSize(17.0)
                } else {
                    cell.textLabel?.text = "Repeat"
                    cell.textLabel?.textColor = UIColor.lightGrayColor()
                }
                
            }
            return cell
        }
        else if indexPath.section == 1 {
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Reminder")!
            cell.imageView?.image = UIImage(named: "alarmclock")
            if let reminderDate = todo.reminder {
                let timeString = timeStringFormatter.stringFromDate(reminderDate)
                cell.textLabel?.text = "Remind me at " + timeString
                cell.textLabel?.textColor = UIColor.blueColor()
                cell.textLabel?.font = UIFont.boldSystemFontOfSize(17.0)
                
                let dateString = dateStringFormatter.stringFromDate(reminderDate)
                cell.detailTextLabel?.text = dateString
            } else {
                cell.textLabel?.text = "Reminder"
                cell.textLabel?.textColor = UIColor.lightGrayColor()
                cell.detailTextLabel?.text = ""
            }
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1{
            return 1
        } else {
            return 0
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
}

