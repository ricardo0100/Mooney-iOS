//
//  CurrencyTextField.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 06/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField, UITextFieldDelegate {
    
    let decimalPlaces = 2
    let currencyPrefix = "R$"
    let decimalSeparator = ","
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        delegate = self
        setValue(0.0)
    }
    
    func getValue() -> NSDecimalNumber {
        var valueString = text?.stringByReplacingOccurrencesOfString(currencyPrefix, withString: "")
        valueString = valueString!.stringByReplacingOccurrencesOfString(decimalSeparator, withString: ".")
        let value = NSDecimalNumber(string: valueString)
        return value
    }
    
    func setValue(value: NSDecimalNumber) {
        let formater = NSNumberFormatter()
        formater.maximumFractionDigits = decimalPlaces
        formater.minimumFractionDigits = decimalPlaces
        formater.minimumIntegerDigits = 1
        formater.decimalSeparator = decimalSeparator
        let stringValue = formater.stringFromNumber(value)!
        text = "\(currencyPrefix) \(stringValue)"
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var newText = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        newText = newText.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
        newText = newText.stringByReplacingOccurrencesOfString(decimalSeparator, withString: "")
        newText = newText.stringByReplacingOccurrencesOfString(currencyPrefix, withString: "")
        newText = newText.stringByReplacingOccurrencesOfString(" ", withString: "")
        let integerNumber = Double(newText)!
        let multiplier = 1 / pow(Double(10), Double(decimalPlaces))
        setValue(NSDecimalNumber(double: integerNumber * multiplier))
        return false
    }
    
}
