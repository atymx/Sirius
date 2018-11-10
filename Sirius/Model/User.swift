//
//  User.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var firstName: String?
    var lastName: String?
    var interests: [String]?
    var achievements: [String]?
    
    static func from(json: JSON) -> User {
        var user = User()
        user.firstName = json["first_name"].string
        user.lastName = json["last_name"].string
        user.interests = []
        for interest in json["interests"].array ?? [] {
            user.interests?.append(interest.string!)
        }
        user.achievements = []
        for achievement in json["achievements"].array ?? [] {
            user.achievements?.append(achievement.string!)
        }
        return user
    }
}
