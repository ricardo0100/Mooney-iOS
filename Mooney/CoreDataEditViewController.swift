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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        prepareObject()
    }

    @IBAction func saveButtonClicked(sender: UIButton) {
        guard let viewDelegate = delegate else {
            return
        }
        
        if object == nil {
            viewDelegate.prepareNewObjectForEdition()
        }
        
        if(viewDelegate.prepareObjectForSaving()) {
            try! managedObjectContext.save()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonChecked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
    
    func prepareObjectForEdition(object: BaseEntity)
    func prepareNewObjectForEdition()
    func prepareObjectForSaving() -> Bool
    
}
