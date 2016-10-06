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
    
    var selectedTodoIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        editButton.title = "Edit"
        view.backgroundColor = UIColor.lightGray
        
        let todo1 = TodoModel(title: "Study iOS", favorited: false, dueDate: Date(), completed: false, repeated: nil, reminder: nil)
        let todo2 = TodoModel(title: "Eat Dinner", favorited: false, dueDate: nil, completed: false, repeated: nil, reminder: nil)
        let todo3 = TodoModel(title: "Gym", favorited: false, dueDate: Date(), completed: false, repeated: nil, reminder: nil)
        
        baseArray = [[todo1, todo2, todo3], []]
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor.clear
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(TodosViewController.longPressRecognized(_:)))
        
        gestureRecognizer.minimumPressDuration = 1.0
        
        tableView.addGestureRecognizer(gestureRecognizer)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        NotificationCenter.default.addObserver(self, selector:#selector(TodosViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TodosViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todosToDoSegue" {
            let indexPath = sender as! IndexPath
            let selectedTodo = baseArray[(indexPath as NSIndexPath).section - 1][(indexPath as NSIndexPath).row]
            
            let todoViewController = segue.destination as! TodoViewController
            todoViewController.todo = selectedTodo
            todoViewController.mainVC = self
            
            
        }
    }
    
    @IBAction func editBarButtonItemTapped(_ sender: UIBarButtonItem) {
        if sender.title == "Edit" {
            if tableView.isEditing {
                tableView.setEditing(false, animated: true)
            }
            else {
                tableView.setEditing(true, animated: true)
            }
        }
            
        else if sender.title == "Done" {
            let indexPathOfAddTodoCell = IndexPath(row: 0, section: 0)
            
            let addTodoTableViewCell = tableView.cellForRow(at: indexPathOfAddTodoCell) as! AddTodoTableViewCell
            
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
                
                let alert = UIAlertController(title: "Invalid Todo", message: "Please enter a title before adding a todo", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                present(alert, animated: true, completion: nil)
                
            }
            
        }
    }
    
    func longPressRecognized (_ gestureRecognizer: UILongPressGestureRecognizer) {
        if !tableView.isEditing {
            tableView.isEditing = true
            if tableView.isEditing {
//                editButton.title = "Done"
                
            }
        }
    }
    
    // MARK - Keyboard Notifications
    
    func keyboardWillShow(_ notification: Notification) {
        navigationItem.rightBarButtonItem?.title = "Done"
    }
    
    func keyboardWillHide(_ notification: Notification) {
        navigationItem.rightBarButtonItem?.title = "Edit"
    }
}

extension TodosViewController: TodoTableViewCellDelegate {
    func completeTodo(_ indexPath: IndexPath) {
        print("Complete Todo")
        
        var selectedTodo = baseArray[(indexPath as NSIndexPath).section - 1][(indexPath as NSIndexPath).row]
        selectedTodo.completed = !selectedTodo.completed
        
        if (indexPath as NSIndexPath).section == 1 {
            baseArray[1].append(selectedTodo)
        } else {
            baseArray[0].append(selectedTodo)
        }
        baseArray[(indexPath as NSIndexPath).section - 1].remove(at: (indexPath as NSIndexPath).row)
        tableView.reloadData()
        
    }
    
    func favoriteTodo(_ indexPath: IndexPath) {
        print("Favorite Todo")
        var selectedToDo = baseArray[(indexPath as NSIndexPath).section - 1][(indexPath as NSIndexPath).row]
        selectedToDo.favorited = !selectedToDo.favorited
        
        baseArray[(indexPath as NSIndexPath).section - 1][(indexPath as NSIndexPath).row] = selectedToDo
        tableView.reloadData()
    }
}

extension TodosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section != 0 {
            performSegue(withIdentifier: "todosToDoSegue", sender: indexPath)
            selectedTodoIndexPath = indexPath
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 && baseArray[1].count > 0 {
            //header height - Might want to change this
            return 25
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return UITableViewCellEditingStyle.none
        }
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension TodosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath as NSIndexPath).section == 0{
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if (indexPath as NSIndexPath).section == 1 {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentToDo = baseArray[0][(sourceIndexPath as NSIndexPath).row]
        baseArray[0].remove(at: (sourceIndexPath as NSIndexPath).row)
        baseArray[0].insert(currentToDo, at: (destinationIndexPath as NSIndexPath).row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            tableView.beginUpdates()
            baseArray[(indexPath as NSIndexPath).section - 1].remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows (at: [indexPath], with: UITableViewRowAnimation.automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).section == 0 {
            let cell: AddTodoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddTodoCell") as! AddTodoTableViewCell
            cell.backgroundColor = UIColor(red: 208/255, green: 198/255, blue: 177/255, alpha: 0.7)
            cell.favoriteButton.backgroundColor = UIColor.orange
            return cell
        } else if (indexPath as NSIndexPath).section == 1 || (indexPath as NSIndexPath).section == 2 {
            let currentTodo = baseArray[(indexPath as NSIndexPath).section - 1][(indexPath as NSIndexPath).row]
            let cell: TodoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoTableViewCell
            cell.titleLabel.text = currentTodo.title
            
            let dateStringFormatter = DateFormatter()
            dateStringFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date = currentTodo.dueDate {
                let dateString = dateStringFormatter.string(from: date as Date)
                cell.dateLabel.text = dateString
            }
            
            if (indexPath as NSIndexPath).section == 1 {
                cell.completeButton.backgroundColor = UIColor.red
            }
            else {
                cell.completeButton.backgroundColor = UIColor.green
            }
            
            if currentTodo.favorited  {
                cell.favoriteButton.backgroundColor = UIColor.blue
            }
            else {
                cell.favoriteButton.backgroundColor = UIColor.orange
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 && baseArray[1].count > 0 {
            return "\(baseArray[1].count) Completed Items"
        }
        return ""
    }
}
