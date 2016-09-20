//
//  Account.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 29/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData


class Account: BaseEntity {

    func sumOfAllTransactions() -> NSDecimalNumber {
        var sum = 0.0
        for transaction in transactionsArray() {
            if transaction.type == TransactionTypes.Credit.rawValue {
                sum = sum + transaction.value!.doubleValue
            } else {
                sum = sum - transaction.value!.doubleValue
            }
        }
        return NSDecimalNumber(double: sum)
    }
    
    func transactionsArray() -> [Transaction] {
        return transactions?.allObjects as! [Transaction]
    }
}
