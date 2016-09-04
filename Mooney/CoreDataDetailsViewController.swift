//
//  CoreDataDetailsViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 03/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class CoreDataDetailsViewController: UIViewController {

    var object: BaseEntity?
    var delegate: CoreDataDetailViewControllerDelegate?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadViewData()
    }
    
    func reloadViewData() {
        //TODO: use guard keyword
        if let dataObject = object, viewDelegate = delegate {
            viewDelegate.reloadViewDataWithObject(dataObject)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Edit" {
            let destinationNavigationController = segue.destinationViewController as! UINavigationController
            let destination =  destinationNavigationController.topViewController as! CoreDataEditViewController
            destination.object = self.object
        }
    }

}

protocol CoreDataDetailViewControllerDelegate {
    
    func reloadViewDataWithObject(object: BaseEntity)
    
}