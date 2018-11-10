//
//  Base.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import Foundation

class Base {
    
    static let shared = Base()
    
    let apiURL = "http://95.213.28.124:5000/"
    
    // Tokens
    
    let defaults = UserDefaults.standard
    
    var token: String? {
        get {
            return defaults.string(forKey: "token")
        }
        set {
            defaults.setValue(newValue, forKey: "token")
        }
    }

    var userId: String? {
        get {
            return defaults.string(forKey: "userId")
        }
        set {
            defaults.set(newValue, forKey: "userId")
        }
    }
    
}
