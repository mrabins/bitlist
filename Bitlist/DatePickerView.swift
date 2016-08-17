//
//  DatePickerView.swift
//  Bitlist
//
//  Created by Mark Rabins on 8/9/16.
//  Copyright © 2016 self.edu. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate {
    func removePressed()
    func donePressed()
    func datePickerValueChanged(date: NSDate)
}

class DatePickerView: UIView {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerViewDelegate?
    
    
    @IBAction func removeBarButtonItemPressed(sender: UIBarButtonItem) {
        delegate?.removePressed()
        
    }
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        delegate?.donePressed()
        
    }
    
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        delegate?.datePickerValueChanged(sender.date)
        
    }


}
