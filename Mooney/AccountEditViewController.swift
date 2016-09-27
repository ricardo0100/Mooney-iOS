//
//  AccountEditViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 04/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class AccountEditViewController: CoreDataEditViewController, CoreDataEditViewControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    //MARK: CoreDataEditViewControllerDelegate
    
    func prepareObjectForEdition(_ object: BaseEntity) {
        if let account = object as? Account {
            nameTextField.text = account.name
        }
    }
    
    func prepareNewObjectForEdition() {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Account", in: managedObjectContext)!
        object = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext) as! Account
    }
    
    func prepareObjectForSaving() -> Bool {
        if let account = object as? Account {
            account.name = nameTextField.text
            return true
        }
        return false
    }

}
