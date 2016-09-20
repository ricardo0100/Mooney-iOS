//
//  Helpers.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 20/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

extension NSDecimalNumber {
    
    func toCurrencyStringWithCurrencySymbol(symbol: String, andDecimalSeparator separator: String) -> String {
        let formater = NSNumberFormatter()
        formater.maximumFractionDigits = 2
        formater.minimumFractionDigits = 2
        formater.minimumIntegerDigits = 1
        formater.decimalSeparator = separator
        let stringValue = formater.stringFromNumber(self)!
        return "\(symbol) \(stringValue)"
    }
    
    func toCurrencyString() -> String {
        return toCurrencyStringWithCurrencySymbol(Configuration.currencySymbol, andDecimalSeparator: Configuration.decimalSeparator)
    }
    
}
