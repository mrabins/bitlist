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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        completeButton.title = "Complete"
        completeButton.tintColor = UIColor.blackColor()
        
        favoriteButton.title = "Favorite"
        favoriteButton.tintColor = UIColor.blackColor()
        
        deleteButton.title = "Delete"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        
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
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
}

