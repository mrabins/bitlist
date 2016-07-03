//
//  TodoTableViewCell.swift
//  Bitlist
//
//  Created by Mark Rabins on 5/28/16.
//  Copyright © 2016 self.edu. All rights reserved.
//

import UIKit

protocol TodoTableViewCellDelegate {
    func completeTodo(indexPath: NSIndexPath)
    func favoriteTodo(indexPath: NSIndexPath)
}

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var indexPath: NSIndexPath!
    var delegate: TodoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func completeButtonTapped(sender: UIButton) {
        delegate?.completeTodo(indexPath)
        
    }
    
    @IBAction func favoriteButtonTapped(sender: UIButton) {
        delegate?.favoriteTodo(indexPath)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            dateLabel.hidden = true
            completeButton.hidden = true
            favoriteButton.hidden = true
        } else {
            dateLabel.hidden = false
            completeButton.hidden = false
            favoriteButton.hidden = false
        }
    }

}
