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
        var valueString = text?.replacingOccurrences(of: Configuration.currencySymbol, with: "")
        valueString = valueString!.replacingOccurrences(of: Configuration.decimalSeparator, with: ".")
        let value = NSDecimalNumber(string: valueString)
        return value
    }
    
    func setValue(_ value: NSDecimalNumber) {
        text = value.toCurrencyString()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Process character concatenation
        var newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        newText = newText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        newText = newText.replacingOccurrences(of: Configuration.decimalSeparator, with: "")
        newText = newText.replacingOccurrences(of: Configuration.currencySymbol, with: "")
        newText = newText.replacingOccurrences(of: " ", with: "")
        let integerNumber = Double(newText)!
        let multiplier = 1 / pow(Double(10), Double(decimalPlaces))
        setValue(NSDecimalNumber(value: integerNumber * multiplier as Double))
        return false
    }
    
}
