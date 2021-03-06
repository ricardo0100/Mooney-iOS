//
//  EditTransactionViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 03/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class TransactionEditViewController: KeyboardScrollCoreDataEditViewController, CoreDataEditViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var valueTextField: CurrencyTextField!
    @IBOutlet weak var accountPickerView: UIPickerView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var transactionTypeSegmentedControl: UISegmentedControl!
    
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
    
    func prepareObjectForEdition(_ object: BaseEntity) {
        if let transaction = object as? Transaction {
            nameTextField.text = transaction.name
            valueTextField.setValue(transaction.value!)
            
            if TransactionTypes.fromString(transaction.type!) == TransactionTypes.Credit {
                transactionTypeSegmentedControl.selectedSegmentIndex = 0
            } else {
                transactionTypeSegmentedControl.selectedSegmentIndex = 1
            }
        }
    }
    
    func prepareNewObjectForEdition() {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Transaction", in: managedObjectContext)!
        object = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext) as! Transaction
    }
    
    func prepareObjectForSaving() -> Bool {
        if let transaction = object as! Transaction? {
            transaction.name = nameTextField.text
            transaction.value = valueTextField.getValue()
            transaction.account = accounts[accountPickerView.selectedRow(inComponent: 0)] as? Account
            transaction.category = categories[categoryPickerView.selectedRow(inComponent: 0)] as? Category
            if transactionTypeSegmentedControl.selectedSegmentIndex == 0 {
                transaction.type = TransactionTypes.Credit.rawValue
            } else {
                transaction.type = TransactionTypes.Debit.rawValue
            }
            return true
        }
        return false
    }
    
    //MARK: UIPickerViewDataSource and UIPickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == accountPickerView {
            return accounts.count
        } else {
            return categories.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == accountPickerView {
            let account = accounts[row] as! Account
            return account.name
        } else {
            let category = categories[row] as! Category
            return category.name
        }
    }
    
}
