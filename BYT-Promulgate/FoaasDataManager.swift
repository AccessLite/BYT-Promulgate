//
//  FoaasDataManager.swift
//  BYT-Promulgate
//
//  Created by Eric Chang on 11/26/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation

class FoaasDataManager {
    
    static let shared: FoaasDataManager = FoaasDataManager()
    private init() {}
    
    private static let operationsKey: String = "FoaasOperationsKey"
    private static let defaults = UserDefaults.standard
    internal private(set) var operations: [FoaasOperation]?
    
    func save(operations: [FoaasOperation]) {
        let data = operations.flatMap { try? $0.toData() }
        FoaasDataManager.defaults.set(data, forKey: FoaasDataManager.operationsKey)
        print("Defaults saved: \(FoaasDataManager.operationsKey)")
    }
    
    func load() -> Bool {
        guard let validData = FoaasDataManager.defaults.value(forKey: FoaasDataManager.operationsKey) as? [Data] else { return false }
        let operations = validData.flatMap{ FoaasOperation(data: $0) }
        FoaasDataManager.shared.operations = operations
        print("Defaults loaded: \(operations)")
        return true
    }
    
    func deleteStoredOperations() {
        FoaasDataManager.defaults.set(nil, forKey: FoaasDataManager.operationsKey)
    }
}
