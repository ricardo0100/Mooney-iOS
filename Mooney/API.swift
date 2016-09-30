//
//  API.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 26/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import Alamofire
import Sync

class API {

    init() {
        sync()
    }
    
    func sync() {
        let headers: HTTPHeaders = [
            "Authorization": "Basic cmljYXJkbzpyaTE1MTQxMw=="
        ]
        
        Alamofire.request("http://localhost:3000/api/accounts", headers: headers).responseJSON { response in
            let dataStack = (UIApplication.shared.delegate as! AppDelegate).dataStack
            if let JSON = response.result.value {
                Sync.changes(
                    JSON as! [[String : Any]],
                    inEntityNamed: "Account",
                    dataStack: dataStack,
                    operations: [.Insert, .Update]) { error in
                        // New objects have been inserted
                        // Existing objects have been updated
                        // And not found objects have been deleted
                }
            }
        }
        
        Alamofire.request("http://localhost:3000/api/categories", headers: headers).responseJSON { response in
            let dataStack = (UIApplication.shared.delegate as! AppDelegate).dataStack
            if let JSON = response.result.value {
                Sync.changes(
                    JSON as! [[String : Any]],
                    inEntityNamed: "Category",
                    dataStack: dataStack,
                    operations: [.Insert, .Update]) { error in
                        // New objects have been inserted
                        // Existing objects have been updated
                        // And not found objects have been deleted
                }
            }
        }
    }
    
}
