//
//  ProfileViewController.swift
//  Sirius
//
//  Created by Максим Атюцкий on 11/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    
    var user: User? = nil
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIServer.shared.getUserInfo(vkId: Int(Base.shared.userId!)!) { (user, error) in
            if let user = user {
                self.user = user
                self.tableView.reloadData()
            }
        }
        
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

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if user == nil { return 0 }
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Основное"
        }
        if section == 1 {
            return "Интересы"
        }
        return nil
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return (user?.interests?.count)!
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainProfileCell", for: indexPath) as! MainProfileCell
            cell.picture.kf.setImage(with: URL(string: (user?.picture)!))
            cell.firstName.text = user?.firstName
            cell.lastName.text = user?.lastName
            return cell
        }
        if indexPath.section == 1 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "#\((user?.interests?[indexPath.item])!)"
            return cell
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
