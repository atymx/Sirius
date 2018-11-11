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
    
    // MARK: - Actions
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        APIServer.shared.addEvent(event: newEvent) { (success) in
            if success == true {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
        return 12
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
        if section == 3 {
            return "Адрес"
        }
        if section == 4 {
            return "Начало мероприятия"
        }
        if section == 5 {
            return "Конец мероприятия"
        }
        if section == 6 {
            return "Контактный email"
        }
        if section == 7 {
            return "Контактные данные"
        }
        if section == 8 {
            return "Имя (Организатор)"
        }
        if section == 9 {
            return "Email (Организатор)"
        }
        if section == 10 {
            return "Контакты (Организатор)"
        }
        if section == 11 {
            return "Описание (Организатор)"
        }
        return nil
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == tableView.numberOfSections - 1 {
            return "\n\n\n\n\n\n\n\n\n\n\n\n\n"
        }
        return nil
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Введите название"
            cell.textField.text = newEvent.name
            
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Введите описание"
            cell.textField.text = newEvent.description
            
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Выберите тип мероприятия"
            cell.textField.text = newEvent.type
            
            let pickerView = UIPickerView()
            pickerView.delegate = cell
            pickerView.dataSource = cell
            cell.textField.inputView = pickerView
            
            let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            toolbar.barStyle = .default
            toolbar.items = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(title: "Готово", style: .plain, target: cell, action: #selector(cell.donePicker))]
            toolbar.sizeToFit()
            cell.textField.inputAccessoryView = toolbar
            
            return cell
        }
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Укажите адрес"
            cell.textField.text = newEvent.placeAddress
            
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Укажите дату и время начала"

            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YYYY HH:mm"
            
            if let start = newEvent.startDatetime {
                cell.textField.text = formatter.string(from: start)
            }
            
            let pickerView = UIDatePicker()
            pickerView.datePickerMode = .dateAndTime
            cell.textField.inputView = pickerView
            
            cell.datePicker = pickerView
            
            let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            toolbar.barStyle = .default
            toolbar.items = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(title: "Готово", style: .plain, target: cell, action: #selector(cell.doneDatePicker))]
            toolbar.sizeToFit()
            cell.textField.inputAccessoryView = toolbar
            
            return cell
        }
        if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Укажите дату и время окончания"
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YYYY HH:mm"
            
            if let end = newEvent.endDatetime {
                cell.textField.text = formatter.string(from: end)
            }
            
            let pickerView = UIDatePicker()
            pickerView.datePickerMode = .dateAndTime
            cell.textField.inputView = pickerView
            
            cell.datePicker = pickerView
            
            let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            toolbar.barStyle = .default
            toolbar.items = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(title: "Готово", style: .plain, target: cell, action: #selector(cell.doneDatePicker))]
            toolbar.sizeToFit()
            cell.textField.inputAccessoryView = toolbar
            
            return cell
        }
        if indexPath.section == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Введите email"
            cell.textField.text = newEvent.contactEmail
            
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        if indexPath.section == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Укажите контактные данные"
            cell.textField.text = newEvent.contactData
            
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        if indexPath.section == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Укажите имя"
            cell.textField.text = newEvent.organizer?.name
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        if indexPath.section == 9 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Укажите email"
            cell.textField.text = newEvent.organizer?.contactEmail
            
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        if indexPath.section == 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Укажите контактные данные"
            cell.textField.text = newEvent.organizer?.contactData
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        if indexPath.section == 11 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textField", for: indexPath) as! TextFieldCell
            cell.addNewEventViewController = self
            cell.indexPath = indexPath
            cell.textField.placeholder = "Добавьте описание"
            cell.textField.text = newEvent.organizer?.description
            
            cell.textField.inputView = nil
            cell.textField.inputAccessoryView = nil
            
            return cell
        }
        return UITableViewCell()
    }
}
