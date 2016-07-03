//
//  AddTodoTableViewCell.swift
//  Bitlist
//
//  Created by Mark Rabins on 5/28/16.
//  Copyright © 2016 self.edu. All rights reserved.
//

import UIKit

class AddTodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addTodoTextField: UITextField!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorited: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        favoriteButton.backgroundColor = UIColor.orangeColor()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteButtonTapped(sender: UIButton) {
        
        if addTodoTextField.isFirstResponder() {
            favorited = !favorited
            
            if favorited {
                favoriteButton.backgroundColor = UIColor.blueColor()
            }
            else {
                favoriteButton.backgroundColor = UIColor.orangeColor()
            }
        }
        
    }
    
}

