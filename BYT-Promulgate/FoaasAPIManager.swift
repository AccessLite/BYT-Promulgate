//
//  FoaasAPIManager.swift
//  BYT-Promulgate
//
//  Created by Eric Chang on 11/26/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation

class FoaasAPIManager {
    private static let defaultSession = URLSession(configuration: .default)
    
    // MARK: - Get FoaaS
    internal class func getFoaas(url: URL, completion: @escaping (Foaas?)->Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("API getFoaas error: \(error)")
            }
            
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                    if let validJson = json {
                        completion(Foaas(json: validJson))
                    }
                }
                catch {
                    print("Doing getFoaas error: \(error)")
                }
            }       
        }.resume()
    }
    
    // MARK: - Get Operations
    internal class func getOperations(completion: @escaping ([FoaasOperation]?)->Void ) {
        let operationEndPoint = "http://www.foaas.com/operations"
        let url = URL(string: operationEndPoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("getOperations error: \(error)")
            }
            
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String:AnyObject]]
                    if let validJson = json {
                        let operations = validJson.flatMap { FoaasOperation(json: $0) }
                        completion(operations)
                    }
                }
                catch {
                    print("Doing getOperation error: \(error)")
                }
            }
        }.resume()
    }
}
