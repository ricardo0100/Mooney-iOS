//
//  BaseEntity.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 29/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData
import SYNCPropertyMapper


class BaseEntity: NSManagedObject {
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        createdAt = Date()
        updatedAt = Date()
    }
    
    static func entityName() -> String {
        return ""
    }
    
    static func fetchObjectsToUpdateInServerWith(context: NSManagedObjectContext) -> [BaseEntity]? {
        let fetchRequest = self.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            return results as? [BaseEntity]
        } catch  {
            return nil
        }
    }
    
    static func jsonObjectsToUpsertInServer(context: NSManagedObjectContext) -> [[String: Any]] {
        var accountsToSend = [[String: Any]]()
        
        if let accounts = self.fetchObjectsToUpdateInServerWith(context: context) {
            for account in accounts {
                let h = account.hyp_dictionary(using: .none)
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: h, options: .prettyPrinted)
                    // here "jsonData" is the dictionary encoded in JSON data
                    
                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    // here "decoded" is of type `Any`, decoded from JSON data
                    
                    // you can now cast it with the right type
                    if let dictFromJSON = decoded as? [String:String] {
                        // use dictFromJSON
                        accountsToSend.append(dictFromJSON)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        
        return accountsToSend
    }
}
