//
//  Organizer.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct Organizer {
    
    var isVerificated: Bool?
    var isPerson: Bool?
    var name: String?
    var contactEmail: String?
    var description: String?
    var contactData: String?
    
    static func from(json: JSON) -> Organizer {
        var organizer = Organizer()
        organizer.isVerificated = json["is_verificated"].bool
        organizer.isPerson = json["is_person"].bool
        organizer.name = json["name"].string
        organizer.contactEmail = json["contact_email"].string
        organizer.description  = json["description"].string
        organizer.contactData = json["contact_data"].string
        return organizer
    }
    
    static func convert(organizer: Organizer) -> Parameters {
        var params: Parameters = [:]
        params["is_verificated"] = organizer.isVerificated
        params["is_person"] = organizer.isPerson
        params["name"] = organizer.name
        params["contact_email"] = organizer.contactEmail
        params["contact_data"] = organizer.contactData
        params["description"] = organizer.description
        return params
    }
    
}
