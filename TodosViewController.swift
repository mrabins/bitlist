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
        print(baseArray)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editBarButtonItem(sender: UIBarButtonItem) {
        
    }
    
    
}
