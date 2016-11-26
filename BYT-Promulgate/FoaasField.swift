//
//  FoaasField.swift
//  BYT-Promulgate
//
//  Created by Eric Chang on 11/26/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation
// Endpoint: /operations
// GET http://www.foaas.com/operations

class FoaasField: JSONConvertible, CustomStringConvertible {
    internal let name: String
    internal let field: String
    var description: String {
        return "Name: \(name). Field: \(field)"
    }
    
    init(name: String, field: String) {
        self.name = name
        self.field = field
    }
    
    convenience required init?(json: [String: AnyObject]) {
        guard
            let name = json["name"] as? String,
            let field = json["field"] as? String
            else { return nil }
        self.init(name: name, field: field)
    }
    
    // MARK: - JSON Convertible
    // MARK: - JSON Convertible
    func toJson() -> [String : AnyObject] {
        let json = [
                    "name" : self.name as AnyObject,
                    "field" : self.field as AnyObject
                    ]
        return json
    }
    
}
