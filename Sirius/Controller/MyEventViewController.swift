//
//  MyEventViewController.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import UIKit

class MyEventViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    
    var event: Event!
    
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

extension MyEventViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Название:"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
                let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
                
                let normalText = event.name!
                let normalString = NSMutableAttributedString(string: normalText)
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 1 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = "Описание: \(event.description ?? "")"
                return cell
            }
            if indexPath.item == 2 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = "Тип мероприятия: \(event.type ?? "")"
                return cell
            }
            if indexPath.item == 3 {
                let cell = UITableViewCell()
                return cell
            }
            if indexPath.item == 4 {
                let cell = UITableViewCell()
                return cell
            }
            if indexPath.item == 5 {
                let cell = UITableViewCell()
                cell.textLabel?.text = event.placeAddress
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
