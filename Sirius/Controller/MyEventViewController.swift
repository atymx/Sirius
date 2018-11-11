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
    
    var event: Event?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Public methods
    
    func update() {
        if event != nil {
            APIServer.shared.getEvent(id: event!.id!, vkId: Int(Base.shared.userId!)!) { (event, error) in
                if let event = event {
                    print(event)
                    self.event = event
                    
                    if event.subscribe == true {
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Отписаться", style: .plain, target: self, action: #selector(self.subscribeButtonClicked))
                    } else {
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Подписаться", style: .plain, target: self, action: #selector(self.subscribeButtonClicked))
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc func subscribeButtonClicked() {
        
        APIServer.shared.subscribe(vkId: Int(Base.shared.userId!)!, eventId: event!.id!) { (event, error) in
            if let event = event {
                self.event = event
                
                if event.subscribe == true {
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Отписаться", style: .plain, target: self, action: #selector(self.subscribeButtonClicked))
                } else {
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Подписаться", style: .plain, target: self, action: #selector(self.subscribeButtonClicked))
                }
                
                self.tableView.reloadData()
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

extension MyEventViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if event == nil {return 0}
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Основная информация"
        }
        if section == 1 {
            return "Организатор"
        }
        return nil
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        if section == 1 {
            return 5
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Название: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                let normalText = event!.name!
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 1 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Описание: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                
                let normalText = event!.description!
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 2 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Тип мероприятия: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
                
                let normalText = event!.type!
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 3 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Начало мероприятия: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
 
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.YYYY HH:mm"
            
                var normalText = ""
                if let start = event!.startDatetime {
                    normalText = formatter.string(from: start)
                } else {
                    normalText = "Онлайн мероприятие"
                }
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 4 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Конец мероприятия: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.YYYY HH:mm"
                
                var normalText = ""
                if let end = event!.endDatetime {
                    normalText = formatter.string(from: end)
                } else {
                    normalText = "Онлайн мероприятие"
                }
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 5 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Адрес: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                
                let normalText = event!.placeAddress ?? "Не указан"
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 6 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Email: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                
                let normalText = event!.contactEmail ?? "Не указан"
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 7 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Контакты: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                
                let normalText = event!.contactData ?? "Не указаны"
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
        }
        if indexPath.section == 1 {
            if indexPath.item == 0 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                if event?.organizer?.isVerificated == true {
                    let boldText = "Верифицирован"
                    let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20),
                                 NSAttributedString.Key.foregroundColor: UIColor(red: 56/255, green: 125/255, blue: 34/255, alpha: 1)]
                    let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                    cell.textLabel?.attributedText = attributedString
                } else {
                    let boldText = "Не верифицирован"
                    let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20),
                                 NSAttributedString.Key.foregroundColor: UIColor.red]
                    let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                    cell.textLabel?.attributedText = attributedString
                }
                return cell
            }
            if indexPath.item == 1 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Имя: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                
                let normalText = event?.organizer?.name ?? "Не указано"
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 2 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Email: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                
                let normalText = event?.organizer?.contactEmail ?? "Не указан"
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 3 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Контакты: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                
                let normalText = event?.organizer?.contactData ?? "Не указаны"
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
                return cell
            }
            if indexPath.item == 4 {
                let cell = UITableViewCell()
                cell.textLabel?.numberOfLines = 0
                
                let boldText  = "Описание: \n"
                let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
                let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
                
                let normalText = event?.organizer?.description ?? "Не указано"
                let normalString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .regular)])
                
                attributedString.append(normalString)
                
                cell.textLabel?.attributedText = attributedString
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
