//
//  AddNewEventViewController.swift
//  Sirius
//
//  Created by Максим Атюцкий on 11/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import UIKit

class AddNewEventViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    
    var newEvent = Event()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddNewEventViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Название"
        }
        if section == 1 {
            return "Описание"
        }
        if section == 2 {
            return "Тип мероприятия"
        }
        return nil
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Введите название"
            
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Введите описание"
            
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Выберите тип мероприятия"
            
            let pickerView = UIPickerView()
            pickerView.delegate = cell
            pickerView.dataSource = cell
            cell.textField.inputView = pickerView
            
            let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            toolbar.barStyle = .default
            toolbar.items = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(cell.donePicker))]
            toolbar.sizeToFit()
            cell.textField.inputAccessoryView = toolbar
            
            return cell
        }
        return UITableViewCell()
    }
}
