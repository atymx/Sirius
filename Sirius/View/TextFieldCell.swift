//
//  TextFieldCell.swift
//  Sirius
//
//  Created by Максим Атюцкий on 11/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    var indexPath: IndexPath!
    var addNewEventViewController: AddNewEventViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.addTarget(self, action: #selector(textFieldEditingChanged(textField:)), for: .editingChanged)
     
        // Initialization code
    }
    
    @objc func textFieldEditingChanged(textField: UITextField) {
        if textField.text?.isEmpty == true {
            textField.text = nil
        }
        
        if indexPath.section == 0 {
            addNewEventViewController.newEvent.name = textField.text
        }
        if indexPath.section == 1 {
            addNewEventViewController.newEvent.description = textField.text
        }
    }
    
    @objc func donePicker() {
        textField.endEditing(true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TextFieldCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Event.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Event.types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = Event.types[row]
        addNewEventViewController.newEvent.type = Event.types[row]
    }
    
}
