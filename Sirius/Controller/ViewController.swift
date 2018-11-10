//
//  ViewController.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import UIKit
import SwiftyVK

class ViewController: UIViewController {

    // MARK: - Vars
    
    var window: UIWindow?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - Actions

    @IBAction func authButtonClicked(_ sender: Any) {
        if let _ = Base.shared.token, let userId = Base.shared.userId {
            APIServer.shared.getUserInfo(vkId: Int(userId)!, handler: { (user, error) in
                if let user = user {
                    print(user)
                    if user.firstName == nil {
                        self.performSegue(withIdentifier: "toSetTags", sender: nil)
                    } else {
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "main")
                        self.window?.rootViewController = vc
                        self.window?.makeKeyAndVisible()
                    }
                }
            })
        } else {
            APIWorker.authorize { (info, error) in
                if let info = info {
                    Base.shared.token = info.0
                    Base.shared.userId = info.1
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

