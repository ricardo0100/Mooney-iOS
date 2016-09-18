//
//  EditTransactionViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 03/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class TransactionEditViewController: CoreDataEditViewController, CoreDataEditViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var valueTextField: CurrencyTextField!
    @IBOutlet weak var accountPickerView: UIPickerView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    var accounts = CoreDataUtils.retrieveAllObjectsWithEntityName("Account")
    var categories = CoreDataUtils.retrieveAllObjectsWithEntityName("Category")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        accountPickerView.delegate = self
        accountPickerView.dataSource = self
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
    }
    
    //MARK: CoreDataEditViewControllerDelegate
    
    func prepareObjectForEdition(object: BaseEntity) {
        if let transaction = object as? Transaction {
            nameTextField.text = transaction.name
            if let value = transaction.value {
                valueTextField.setValue(value)
            }
        }
    }
    
    func prepareNewObjectForEdition() {
        let entityDescription = NSEntityDescription.entityForName("Transaction", inManagedObjectContext: managedObjectContext)!
        object = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext) as! Transaction
    }
    
    func prepareObjectForSaving() -> Bool {
        if let transaction = object as! Transaction? {
            transaction.name = nameTextField.text
            transaction.value = valueTextField.getValue()
            transaction.account = accounts[accountPickerView.selectedRowInComponent(0)] as? Account
            transaction.category = categories[categoryPickerView.selectedRowInComponent(0)] as? Category
            return true
        }
        return false
    }
    
    //MARK: UIPickerViewDataSource and UIPickerViewDelegate
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == accountPickerView {
            return accounts.count
        } else {
            return categories.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == accountPickerView {
            let account = accounts[row] as! Account
            return account.name
        } else {
            let category = categories[row] as! Category
            return category.name
        }
    }
    
}
