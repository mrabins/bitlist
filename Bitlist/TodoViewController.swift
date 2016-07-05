//
//  TodoViewController.swift
//  Bitlist
//
//  Created by Mark Rabins on 7/4/16.
//  Copyright © 2016 self.edu. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {
    
    @IBOutlet weak var completeButton: UIBarButtonItem!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        completeButton.title = "Complete"
        completeButton.tintColor = UIColor.blackColor()
        
        favoriteButton.title = "Favorite"
        favoriteButton.tintColor = UIColor.blackColor()
        
        deleteButton.title = "Delete"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
