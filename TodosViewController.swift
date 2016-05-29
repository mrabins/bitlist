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


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        editButton.title = "Edit"
        view.backgroundColor = UIColor.lightGrayColor()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editBarButtonItem(sender: UIBarButtonItem) {
        
    }
    
    
}
