//
//  SetSubTagsViewController.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import UIKit

class SetSubTagsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    
    var setTagsViewController: SetTagsViewController!
    
    var tags: [String] = []
    var subtags: [String: [String]] = [:]
    var checkedSubTags: [String: Bool] = [:]
    var filledTag: [String: Int] = [:]
    
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for tag in setTagsViewController.tags {
            if setTagsViewController.tagsChecked[tag] == true {
                tags.append(tag)
                filledTag[tag] = 0
            }
        }
        
        subtags = setTagsViewController.subtags
        
        for subtag in subtags.keys {
            checkedSubTags[subtag] = false
        }
        
        update()
        
        // Do any additional setup after loading the view.
    }
    
    func update() {
        
        var f = true
        
        for tag in tags {
            if filledTag[tag] == 0 {
                f = false
            }
        }
        
        if f {
            doneButton.isHidden = false
        } else {
            doneButton.isHidden = true
        }
        
        tableView.reloadData()
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        var interests: [String] = []
        var events: [String] = []
        
        for tag in tags {
            interests.append(tag)
            for subtag in subtags[tag]! {
                if checkedSubTags[subtag] == true {
                    interests.append("\(tag)/\(subtag)")
                }
            }
        }
        
        APIServer.shared.register(vkId: Int(Base.shared.userId!)!, interests: interests, events: events) { (success, error) in
            if success {
                print("OK!")
            }
        }
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

extension SetSubTagsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tags.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subtags[tags[section]]!.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tags[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = subtags[tags[indexPath.section]]![indexPath.item]
        if checkedSubTags[subtags[tags[indexPath.section]]![indexPath.item]] == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if checkedSubTags[subtags[tags[indexPath.section]]![indexPath.item]] == true {
            checkedSubTags[subtags[tags[indexPath.section]]![indexPath.item]] = false
            filledTag[tags[indexPath.section]] = filledTag[tags[indexPath.section]]! - 1
        } else {
            checkedSubTags[subtags[tags[indexPath.section]]![indexPath.item]] = true
            filledTag[tags[indexPath.section]] = filledTag[tags[indexPath.section]]! + 1
        }
        update()
    }
}
