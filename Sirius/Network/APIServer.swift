//
//  APIServer.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIServer {
    
    static let shared = APIServer()
    
    // MARK: - Public methods
    
    func getCategories(handler: @escaping (([String: [String]]?, Error?)->Void)) {
        _getCategories(handler: handler)
    }

    func getUserInfo(vkId: Int, handler: @escaping ((User?, Error?)->Void)) {
        _getUserInfo(vkId: vkId, handler: handler)
    }
    
    func register(vkId: Int, interests: [String], events: [String], handler: @escaping ((Bool, Error?)->Void)) {
        _register(vkId: vkId, interests: interests, events: events, handler: handler)
    }
    
    func getEvents(vkId: Int, handler: @escaping (([Event]?, Error?)->Void)) {
        _getEvents(vkId: vkId, handler: handler)
    }
    
    func subscribe(vkId: Int, eventId: Int, handler: @escaping ((Event?, Error?)->Void)) {
        _subscribe(vkId: vkId, eventId: eventId, handler: handler)
    }
    
    func getEvent(id: Int, vkId: Int, handler: @escaping ((Event?, Error?)->Void)) {
        _getEvent(id: id, vkId: vkId, handler: handler)
    }
    
    func getAllEvents(byLocation: Bool, vkId: Int, handler: @escaping (([Event]?, Error?)->Void)) {
        _getAllEvents(byLocation: byLocation, vkId: vkId, handler: handler)
    }
    
    // MARK: - Private methods
    
    private func _getUserInfo(vkId: Int, handler: @escaping ((User?, Error?)->Void)) {
        Alamofire
            .request(Base.shared.apiURL + "get_user_info/?id=\(vkId)", method: .get)
            .responseJSON { (response) in
                
                switch response.result {
                case .success(_):
                    let json = try? JSON(data: response.data!)
                    handler(User.from(json: json!), nil)
                case .failure(let error):
                    handler(nil, error)
                }
            }
    }
    
    private func _getCategories(handler: @escaping (([String: [String]]?, Error?)->Void)) {
        Alamofire
            .request(Base.shared.apiURL + "get_all_categories/", method: .get)
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    let json = try? JSON(data: response.data!)
                    var tags: [String: [String]] = [:]
                    for tag in (json?.dictionary?.keys)! {
                        var subtags: [String] = []
                        for subtag in json![tag].array ?? [] {
                            subtags.append(subtag.string!)
                        }
                        tags[tag] = subtags
                    }
                    handler(tags, nil)
                case .failure(let error):
                    handler(nil, error)
                }
            }
    }
    
    private func _register(vkId: Int, interests: [String], events: [String], handler: @escaping ((Bool, Error?)->Void)) {
        let params: Parameters = [
            "vk_id": vkId,
            "interests": interests,
            "events": events
        ]
        Alamofire
            .request(Base.shared.apiURL + "register/", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    handler(true, nil)
                case .failure(let error):
                    handler(false, error)
                }
            }
    }
    
    private func _getEvents(vkId: Int, handler: @escaping (([Event]?, Error?)->Void)) {
        Alamofire
            .request(Base.shared.apiURL + "get_user_events/?vk_id=\(vkId)", method: .get)
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    let json = try? JSON(data: response.data!)
                    var events: [Event] = []
                    for event in json?.array ?? [] {
                        events.append(Event.from(json: event))
                    }
                    handler(events, nil)
                case .failure(let error):
                    handler(nil, error)
                }
            }
    }
    
    private func _subscribe(vkId: Int, eventId: Int, handler: @escaping ((Event?, Error?)->Void)) {
        Alamofire
            .request(Base.shared.apiURL + "subscribe/?user_id=\(vkId)&event_id=\(eventId)", method: .get)
            .responseJSON { (response) in
                print("response \(response)")
                switch response.result {
                case .success(_):
                    let json = try? JSON(data: response.data!)
                    handler(Event.from(json: json!), nil)
                case .failure(let error):
                    handler(nil, error)
                }
            }
    }
    
    private func _getEvent(id: Int, vkId: Int, handler: @escaping ((Event?, Error?)->Void)) {
        Alamofire
            .request(Base.shared.apiURL + "get_event_by_id/?user_id=\(vkId)&event_id=\(id)", method: .get)
            .responseJSON { (response) in
                print(response)
                switch response.result {
                case .success(_):
                    let json = try? JSON(data: response.data!)
                    handler(Event.from(json: json!), nil)
                case .failure(let error):
                    handler(nil, error)
                }
            }
    }
    
    private func _getAllEvents(byLocation: Bool, vkId: Int, handler: @escaping (([Event]?, Error?)->Void)) {
        Alamofire
            .request(Base.shared.apiURL + "get_events/?by_location=\(byLocation)&user_id=\(vkId)", method: .get)
            .responseJSON { (response) in
            
                switch response.result {
                case .success(_):
                    let json = try? JSON(data: response.data!)
                    var events: [Event] = []
                    for event in json?.array ?? [] {
                        events.append(Event.from(json: event))
                    }
                    handler(events, nil)
                case .failure(let error):
                    handler(nil, error)
                }
            }
    }
    
}
