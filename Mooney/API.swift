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
    
    let apiURL = "http://localhost:3000/api"

    let headers: HTTPHeaders = [
        "Authorization": "Basic cmljYXJkbzpyaTE1MTQxMw=="
    ]
    
    init() {
        sync()
    }
    
    func sync() {
        self.syncAccounts {
            print("Sync Accounts completed")
            self.syncCategories {
                print("Sync Categories completed")
                self.syncTransactions {
                    print("Sync Transactions completed")
                }
            }
        }
    }
    
    func syncAccounts(completion: @escaping () -> Void) {
        Alamofire.request("\(self.apiURL)/accounts", headers: self.headers).responseJSON { response in
            let dataStack = (UIApplication.shared.delegate as! AppDelegate).dataStack
            if let JSON = response.result.value {
                Sync.changes(
                    JSON as! [[String : Any]],
                    inEntityNamed: "Account",
                    dataStack: dataStack,
                    operations: [.Insert, .Update]) { error in
                        completion()
                }
            }
        }
    }
    
    func syncCategories(completion: @escaping () -> Void) {
        Alamofire.request("\(self.apiURL)/categories", headers: self.headers).responseJSON { response in
            let dataStack = (UIApplication.shared.delegate as! AppDelegate).dataStack
            if let JSON = response.result.value {
                Sync.changes(
                    JSON as! [[String : Any]],
                    inEntityNamed: "Category",
                    dataStack: dataStack,
                    operations: [.Insert, .Update]) { error in
                        completion()
                }
            }
        }
    }
    
    func syncTransactions(completion: @escaping () -> Void) {
        Alamofire.request("\(self.apiURL)/transactions", headers: self.headers).responseJSON { response in
            let dataStack = (UIApplication.shared.delegate as! AppDelegate).dataStack
            if let JSON = response.result.value {
                Sync.changes(
                    JSON as! [[String : Any]],
                    inEntityNamed: "Transaction",
                    dataStack: dataStack,
                    operations: [.Insert, .Update]) { error in
                        completion()
                }
            }
        }
    }
    
}
