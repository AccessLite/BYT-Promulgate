//
//  FoaasOperation.swift
//  BYT-Promulgate
//
//  Created by Eric Chang on 11/26/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation
// Endpoint: /operations
// GET http://www.foaas.com/operations

class FoaasOperation: JSONConvertible, DataConvertible {
    
    internal let name: String
    internal var url: String
    internal let fields: [FoaasField]

    init(name: String, url: String, fields: [FoaasField]) {
        self.name = name
        self.url = url
        self.fields = fields
    }
 
    // MARK: - JSON Convertible
    // MARK: - JSON Convertible
    func toJson() -> [String : AnyObject] {
        let json = [
            "name" : self.name as AnyObject,
            "url" : self.url as AnyObject,
            "fields" : self.fields.map { $0.toJson() } as AnyObject
            ]
        return json
    }
    
    convenience required init?(json: [String: AnyObject]) {
        guard
            let name = json["name"] as? String,
            let url = json["url"] as? String,
            let fields = json["fields"] as? [[String: AnyObject]]
            else { return nil }
        let fieldsObject: [FoaasField] = fields.flatMap { FoaasField(json: $0) }
        self.init(name: name, url: url, fields: fieldsObject)
    }
    
    // MARK: - Data Convertible
    // MARK: - Data Convertible
    func toData() throws -> Data {
        return try JSONSerialization.data(withJSONObject: self.toJson(), options: [])
    }
    
    convenience required init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                self.init(json: json)
            }
            else {
                return nil
            }
        }
        catch {
            print("FoaasOperation Error: convenience init")
            return nil
        }
    }
}
