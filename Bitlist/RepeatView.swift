//
//  RepeatView.swift
//  Bitlist
//
//  Created by Mark Rabins on 8/24/16.
//  Copyright © 2016 self.edu. All rights reserved.
//

import UIKit

protocol RepeatViewDelegate {
    func remove()
    func done()
    func pickerViewDidSelect(_ type: RepeatType)
}

class RepeatView: UIView {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var delegate: RepeatViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    @IBAction func removeBarButtonItemPressed(_ sender: UIBarButtonItem) {
        delegate?.remove()
    }
    
    @IBAction func doneBarButtonItemPressed(_ sender: UIBarButtonItem) {
        delegate?.done()
    }

}

extension RepeatView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch row {
        case 0:
            return "Every Day"
        case 1:
            return "Every Week"
        case 2:
            return "Every Month"
        default:
            return "Every Year"
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let repeatValue = RepeatType(rawValue: row)!
        delegate?.pickerViewDidSelect(repeatValue)
    }
}

extension RepeatView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
}
