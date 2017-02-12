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
    
    static let sharedInstance = API()
    
    let dataStack = (UIApplication.shared.delegate as! AppDelegate).dataStack
    let apiURL = "http://localhost:8080/api"

    let headers: HTTPHeaders = [
        "Authorization": "Basic cmljYXJkbzAxMDBAZ21haWwuY29tOjEyMzQ1Ng=="
    ]
    
    func sync() {
        sendLocalChangesToServer()
        retrieveChangesFromServer()
    }
    
    //MARK: Send local changes to server
    
    func sendLocalChangesToServer() {
        sendAccounts()
    }
    
    func sendAccounts() {
        let url = URL(string: "\(self.apiURL)/accounts")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = self.headers
        
        let accounts = Account.jsonObjectsToUpsertInServer(context: self.dataStack.mainContext)
        for account in accounts {
            let data = try! JSONSerialization.data(withJSONObject: account)
            request.httpBody = data
            Alamofire.request(request)
                .responseJSON { response in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                        
                        if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                            print(responseString)
                        }
                    case .success(let responseObject):
                        print(responseObject)
                    }
            }
        }
    }
 
    //MARK: Retrieve changes from server
    
    func retrieveChangesFromServer() {
        self.retrieveAccounts {
            print("Retrieving Accounts completed")
            self.retrieveCategories {
                print("Retrieving Categories completed")
                self.retrieveTransactions {
                    print("Retrieving Transactions completed")
                }
            }
        }
    }
    
    func retrieveAccounts(completion: @escaping () -> Void) {
        Alamofire.request("\(self.apiURL)/accounts", headers: self.headers).responseJSON { response in
            if let JSON = response.result.value {
                Sync.changes(
                    JSON as! [[String : Any]],
                    inEntityNamed: "Account",
                    dataStack: self.dataStack,
                    operations: [.Insert, .Update]) { error in
                        completion()
                }
            }
        }
    }
    
    func retrieveCategories(completion: @escaping () -> Void) {
        Alamofire.request("\(self.apiURL)/categories", headers: self.headers).responseJSON { response in
            if let JSON = response.result.value {
                Sync.changes(
                    JSON as! [[String : Any]],
                    inEntityNamed: "Category",
                    dataStack: self.dataStack,
                    operations: [.Insert, .Update]) { error in
                        completion()
                }
            }
        }
    }
    
    func retrieveTransactions(completion: @escaping () -> Void) {
        Alamofire.request("\(self.apiURL)/transactions", headers: self.headers).responseJSON { response in
            if let JSON = response.result.value {
                Sync.changes(
                    JSON as! [[String : Any]],
                    inEntityNamed: "Transaction",
                    dataStack: self.dataStack,
                    operations: [.Insert, .Update]) { error in
                        completion()
                }
            }
        }
    }
    
}
