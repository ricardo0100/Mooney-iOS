//
//  Configuration.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 20/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

enum TransactionTypes: String {
    case Debit = "Debit"
    case Credit = "Credit"
    
    static func fromString(string: String) -> TransactionTypes {
        switch string {
        case Credit.rawValue:
            return Credit
        default:
            return Debit
        }
    }
}

class Configuration {
    
    static let currencySymbol = "R$"
    static let decimalSeparator = ","
    
}