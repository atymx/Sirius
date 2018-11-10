//
//  SetTagsViewController.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import UIKit

class SetTagsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Vars
    
    var tags: [String] = []
    var subtags: [String: [String]] = [:]
    var tagsChecked: [String: Bool] = [:]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIServer.shared.getCategories { (tags, error) in
            self.tags = []
            self.tagsChecked = [:]
            for tag in (tags?.keys)! {
                self.tags.append(tag)
                self.subtags[tag] = tags![tag]
                self.tagsChecked[tag] = false
            }
            self.update()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func update() {
        var f = false
        
        for tag in tags {
            if tagsChecked[tag] == true {
                f = true
            }
        }
        
        if f {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
        
        tableView.reloadData()
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toSetSubTags", sender: nil)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toSetSubTags" {
            if let destination = segue.destination as? SetSubTagsViewController {
                destination.setTagsViewController = self
            }
        }
    }

}

extension SetTagsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tags[indexPath.item]
        if tagsChecked[tags[indexPath.item]] == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tagsChecked[tags[indexPath.item]] = !(tagsChecked[tags[indexPath.item]])!
        update()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
