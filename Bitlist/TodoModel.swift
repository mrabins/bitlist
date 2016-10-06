//
//  TodoModel.swift
//  Bitlist
//
//  Created by Mark Rabins on 5/30/16.
//  Copyright © 2016 self.edu. All rights reserved.
//

import Foundation

enum RepeatType: Int {
    case daily = 0
    case weekly = 1
    case monthly = 2
    case yearly = 3
}


struct TodoModel {
    var title: String
    var favorited: Bool
    var dueDate: Date?
    var completed: Bool
    
    var repeated: RepeatType?
    var reminder: Date?
    
}
