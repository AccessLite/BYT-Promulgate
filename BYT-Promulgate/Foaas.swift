//
//  Foaas.swift
//  BYT-Promulgate
//
//  Created by Eric Chang on 11/26/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation
// Enpoint: /awesome/:from
// GET http://www.foaas.com/awesome/louis

class Foaas: JSONConvertible, CustomStringConvertible {
    
    internal let message: String
    internal let subtitle: String
    var description: String {
        return "\(message) \n \(subtitle)"
    }
    
    init(message: String, subtitle: String) {
        self.message = message
        self.subtitle = subtitle
    }
    
    convenience required init?(json: [String : AnyObject]) {
        guard
            let message = json["message"] as? String,
            let subtitle = json["subtitle"] as? String
            else { return nil }
        self.init(message: message, subtitle: subtitle)
    }
    
    // MARK: - JSON Convertible
    // MARK: - JSON Convertible
    func toJson() -> [String : AnyObject] {
        let json = [
                    "message": self.message as AnyObject,
                    "subtitle": self.subtitle as AnyObject
                    ]
        return json
    }
}
