//
//  CoreDataTableViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 28/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var delegate: CoreDataTableViewControllerDelegate?
    var managedObjectContext = AppDelegate.sharedAppDelegate().managedObjectContext
    
    var entityName: String? {
        return nil
    }
    
    var fetchedResultsController: NSFetchedResultsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let entity = entityName {
            let fetchRequest = NSFetchRequest(entityName: entity)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: managedObjectContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
            fetchedResultsController?.delegate = self
        }
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        performFetch()
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return !tableView.editing
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Select" {
            let destination = segue.destinationViewController as! CoreDataDetailsViewController
            destination.object = fetchedResultsController!.objectAtIndexPath(tableView.indexPathForSelectedRow!) as? BaseEntity
        }
        if segue.identifier == "Edit" {
            let destinationNavigationController = segue.destinationViewController as! UINavigationController
            let destination =  destinationNavigationController.topViewController as! CoreDataEditViewController
            let indexPath = sender as! NSIndexPath
            destination.object = fetchedResultsController!.objectAtIndexPath(indexPath) as? BaseEntity
        }
    }
    
    func performFetch() {
        if let resultsController = fetchedResultsController {
            //TODO: manage errors
            try! resultsController.performFetch()
        }
    }
    
    //MARK: NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            break
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
            break
        case .Move:
            if indexPath == newIndexPath {
                tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            } else {
                tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
            }
            break
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    //MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let results = fetchedResultsController, let sections = results.sections {
            return sections.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = fetchedResultsController, let sections = results.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if let results = fetchedResultsController {
            let object = results.objectAtIndexPath(indexPath) as! BaseEntity
            cell.textLabel?.text = object.name
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteRowAction = UITableViewRowAction(style: .Default, title: "Delete") { (rowAction, indexPath) in
            if let results = self.fetchedResultsController {
                let object = results.objectAtIndexPath(indexPath) as! BaseEntity
                self.showDeleteConfirmationDialogForObject(object)
            }
        }
        let editRowAction = UITableViewRowAction(style: .Normal, title: "Edit") { (rowAction, indexPath) in
            self.performSegueWithIdentifier("Edit", sender: indexPath)
        }
        return [deleteRowAction, editRowAction]
    }
    
    func showDeleteConfirmationDialogForObject(object: BaseEntity) {
        let alertController = UIAlertController(title: "Warning", message: "Delete \(object.name!)?", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            self.tableView.setEditing(false, animated: true)
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Delete", style: .Destructive) { (action) in
            self.managedObjectContext.deleteObject(object)
            try! self.managedObjectContext.save()
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

protocol CoreDataTableViewControllerDelegate {
    
}
