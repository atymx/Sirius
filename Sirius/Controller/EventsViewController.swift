//
//  EventsViewController.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    // MARK: - Vars
    
    var events: [Event] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        update()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Public methods
    
    func update() {
        APIServer.shared.getAllEvents(byLocation: segment.selectedSegmentIndex == 0 ? false : true, vkId: Int(Base.shared.userId!)!) { (events, error) in
            if let events = events {
                self.events = events
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        
    }
    
    @IBAction func addEventButtonClicked(_ sender: Any) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toMyEvent" {
            if let destination = segue.destination as? MyEventViewController {
                destination.event = (sender as! Event)
            }
        }
    }

}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.numberOfLines = 0

        let attributedString = NSMutableAttributedString(string: "Название:\n",
                                                         attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        attributedString.append(NSMutableAttributedString(string: events[indexPath.item].name ?? "Отсутствует",
                                                          attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .regular)]))
        attributedString.append(NSMutableAttributedString(string: "\nТип:\n",
                                                          attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold)]))
        attributedString.append(NSMutableAttributedString(string: events[indexPath.item].type ?? "Отсутствует",
                                                          attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .regular)]))
        attributedString.append(NSMutableAttributedString(string: "\nАдрес:\n",
                                                          attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold)]))
        attributedString.append(NSMutableAttributedString(string: events[indexPath.item].placeAddress ?? "Отсутствует",
                                                          attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .regular)]))
        
        
        cell.textLabel?.attributedText = attributedString
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toMyEvent", sender: events[indexPath.item])
    }
}

