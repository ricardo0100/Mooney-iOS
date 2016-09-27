//
//  CategryEditViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 04/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class CategoryEditViewController: CoreDataEditViewController, CoreDataEditViewControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    //MARK: CoreDataEditViewControllerDelegate
    
    func prepareObjectForEdition(_ object: BaseEntity) {
        if let category = object as? Category {
            nameTextField.text = category.name
        }
    }
    
    func prepareNewObjectForEdition() {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Category", in: managedObjectContext)!
        object = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext) as! Category
    }
    
    func prepareObjectForSaving() -> Bool {
        if let category = object as? Category {
            category.name = nameTextField.text
            return true
        }
        return false
    }

}
