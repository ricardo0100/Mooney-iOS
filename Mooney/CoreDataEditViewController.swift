//
//  CoreDataEditViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 03/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class CoreDataEditViewController: UIViewController {
    
    var object: BaseEntity?
    var delegate: CoreDataEditViewControllerDelegate?
    let managedObjectContext = AppDelegate.sharedAppDelegate().managedObjectContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareObject()
    }

    @IBAction func saveButtonClicked(_ sender: UIButton) {
        guard let viewDelegate = delegate else {
            return
        }
        
        if object == nil {
            viewDelegate.prepareNewObjectForEdition()
        }
        
        if(viewDelegate.prepareObjectForSaving()) {
            try! managedObjectContext.save()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonChecked(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func prepareObject() {
        guard let viewDelegate = delegate else {
            return
        }
        if let data = object {
            viewDelegate.prepareObjectForEdition(data)
        }
    }

}

protocol CoreDataEditViewControllerDelegate {
    
    func prepareObjectForEdition(_ object: BaseEntity)
    func prepareNewObjectForEdition()
    func prepareObjectForSaving() -> Bool
    
}
