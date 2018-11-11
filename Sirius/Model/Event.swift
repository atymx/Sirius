//
//  Event.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct Event {
    
    var description: String?
    var organizer: Organizer?
    var id: Int?
    var contactEmail: String?
    var name: String?
    var contactData: String?
    var placeAddress: String?
    var type: String?
    
    var startDatetime: Date?
    var endDatetime: Date?
    
    var subscribe: Bool?
    
    static let types = ["Выездная школа", "Кружок", "Единоразовое мероприятие", "Другое", "Онлайн-курсы"]
    
    static func from(json: JSON) -> Event {
        var event = Event()

        event.description = json["description"].string
        event.organizer = Organizer.from(json: json["organizer"])
        event.id = json["id"].int
        event.contactEmail = json["contact_email"].string
        event.name = json["name"].string
        event.contactData = json["contact_data"].string
        event.type = json["type"].string
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let startDatetime = json["start_datetime"].string {
            event.startDatetime = dateFormatter.date(from: startDatetime)
        }
        if let endDatetime = json["finish_datetime"].string {
            event.endDatetime = dateFormatter.date(from: endDatetime)
        }
        
        event.subscribe = json["subscribe"].bool
        
        return event
    }
 
    static func convert(event: Event) -> Parameters {
        var params: Parameters = [:]
        params["description"] = event.description
        params["organizer"] = Organizer.convert(organizer: event.organizer!)
        params["id"] = event.id
        params["contact_email"] = event.contactEmail
        params["name"] = event.name
        params["contact_data"] = event.contactData
        params["place_address"] = event.placeAddress
        params["type"] = event.type
        params["subscribe"] = event.subscribe
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let start = event.startDatetime {
            params["start_datetime"] = formatter.string(from: start)
        }
        if let end = event.endDatetime {
            params["finish_datetime"] = formatter.string(from: end)
        }
        
        return params
    }
    
}
