//
//  TodoModel.swift
//  Bitlist
//
//  Created by Mark Rabins on 5/30/16.
//  Copyright © 2016 self.edu. All rights reserved.
//

import Foundation

enum RepeatType: Int {
    case Daily = 0
    case Weekly = 1
    case Monthly = 2
    case Yearly = 3
}


struct TodoModel {
    var title: String
    var favorited: Bool
    var dueDate: NSDate?
    var completed: Bool
    
    var repeated: RepeatType?
    var reminder: NSDate?
    
}