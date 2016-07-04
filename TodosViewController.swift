//
//  TodosViewController.swift
//  Bitlist
//
//  Created by Mark Rabins on 5/26/16.
//  Copyright © 2016 self.edu. All rights reserved.
//

import UIKit

class TodosViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var baseArray: [[TodoModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        editButton.title = "Edit"
        view.backgroundColor = UIColor.lightGrayColor()
        
        let todo1 = TodoModel(title: "Study iOS", favorited: false, dueDate: NSDate(), completed: false, repeated: nil, reminder: nil)
        let todo2 = TodoModel(title: "Eat Dinner", favorited: false, dueDate: nil, completed: false, repeated: nil, reminder: nil)
        let todo3 = TodoModel(title: "Gym", favorited: false, dueDate: NSDate(), completed: false, repeated: nil, reminder: nil)
        
        baseArray = [[todo1, todo2, todo3], []]
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor.clearColor()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressRecognized:")
        
        gestureRecognizer.minimumPressDuration = 1.0
        
        tableView.addGestureRecognizer(gestureRecognizer)
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(TodosViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TodosViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editBarButtonItemTapped(sender: UIBarButtonItem) {
        if sender.title == "Edit" {
            if tableView.editing {
                tableView.setEditing(false, animated: true)
            }
            else {
                tableView.setEditing(true, animated: true)
            }
        }
            
        else if sender.title == "Done" {
            let indexPathOfAddTodoCell = NSIndexPath(forRow: 0, inSection: 0)
            
            let addTodoTableViewCell = tableView.cellForRowAtIndexPath(indexPathOfAddTodoCell) as! AddTodoTableViewCell
            
            if addTodoTableViewCell.addTodoTextField.text != "" {
                
                let newTodo = TodoModel(title: addTodoTableViewCell.addTodoTextField.text!, favorited: addTodoTableViewCell.favorited, dueDate: nil, completed: false, repeated: nil, reminder: nil)
                
                baseArray[0].append(newTodo)
                
                tableView.reloadData()
                
                addTodoTableViewCell.addTodoTextField.text = ""
                addTodoTableViewCell.addTodoTextField.resignFirstResponder()
                
                if addTodoTableViewCell.addTodoTextField.text == nil {
                    return addTodoTableViewCell.addTodoTextField.text = ""
                }
                
            }
            else {
                
                let alert = UIAlertController(title: "Invalid Todo", message: "Please enter a title before adding a todo", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
                
            }
            
        }
    }
    
    func longPressRecognized (gestureRecognizer: UILongPressGestureRecognizer) {
        if !tableView.editing {
            tableView.editing = true
            if tableView.editing {
//                editButton.title = "Done"
                
            }
        }
    }
    
    // MARK - Keyboard Notifications
    
    func keyboardWillShow(notification: NSNotification) {
        navigationItem.rightBarButtonItem?.title = "Done"
    }
    
    func keyboardWillHide(notification: NSNotification) {
        navigationItem.rightBarButtonItem?.title = "Edit"
    }
}

extension TodosViewController: TodoTableViewCellDelegate {
    func completeTodo(indexPath: NSIndexPath) {
        print("Complete Todo")
        
        var selectedTodo = baseArray[indexPath.section - 1][indexPath.row]
        selectedTodo.completed = !selectedTodo.completed
        
        if indexPath.section == 1 {
            baseArray[1].append(selectedTodo)
        } else {
            baseArray[0].append(selectedTodo)
        }
        baseArray[indexPath.section - 1].removeAtIndex(indexPath.row)
        tableView.reloadData()
        
    }
    
    func favoriteTodo(indexPath: NSIndexPath) {
        print("Favorite Todo")
        var selectedToDo = baseArray[indexPath.section - 1][indexPath.row]
        selectedToDo.favorited = !selectedToDo.favorited
        
        baseArray[indexPath.section - 1][indexPath.row] = selectedToDo
        tableView.reloadData()
    }
}

extension TodosViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 && baseArray[1].count > 0 {
            //header height - Might want to change this
            return 25
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if tableView.editing {
            return UITableViewCellEditingStyle.None
        }
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}

extension TodosViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0{
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 1 {
            return true
        } else {
            return false
        }
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let currentToDo = baseArray[0][sourceIndexPath.row]
        baseArray[0].removeAtIndex(sourceIndexPath.row)
        baseArray[0].insert(currentToDo, atIndex: destinationIndexPath.row)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            tableView.beginUpdates()
            baseArray[indexPath.section - 1].removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths ([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: AddTodoTableViewCell = tableView.dequeueReusableCellWithIdentifier("AddTodoCell") as! AddTodoTableViewCell
            cell.backgroundColor = UIColor(red: 208/255, green: 198/255, blue: 177/255, alpha: 0.7)
            cell.favoriteButton.backgroundColor = UIColor.orangeColor()
            return cell
        } else if indexPath.section == 1 || indexPath.section == 2 {
            let currentTodo = baseArray[indexPath.section - 1][indexPath.row]
            let cell: TodoTableViewCell = tableView.dequeueReusableCellWithIdentifier("TodoCell") as! TodoTableViewCell
            cell.titleLabel.text = currentTodo.title
            
            let dateStringFormatter = NSDateFormatter()
            dateStringFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date = currentTodo.dueDate {
                let dateString = dateStringFormatter.stringFromDate(date)
                cell.dateLabel.text = dateString
            }
            
            if indexPath.section == 1 {
                cell.completeButton.backgroundColor = UIColor.redColor()
            }
            else {
                cell.completeButton.backgroundColor = UIColor.greenColor()
            }
            
            if currentTodo.favorited  {
                cell.favoriteButton.backgroundColor = UIColor.blueColor()
            }
            else {
                cell.favoriteButton.backgroundColor = UIColor.orangeColor()
            }
            
            cell.backgroundColor = UIColor(red: 235/255, green: 176/255, blue: 53/255, alpha: 0.7)
            
            cell.indexPath = indexPath
            cell.delegate = self
            
            return cell
            
        }
        else {
            return UITableViewCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return baseArray[0].count
        }
        else  if section == 2 {
            return baseArray[1].count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 && baseArray[1].count > 0 {
            return "\(baseArray[1].count) Completed Items"
        }
        return ""
    }
}
