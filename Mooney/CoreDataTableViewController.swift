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
    
    var fetchedResultsController: NSFetchedResultsController<BaseEntity>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let entity = entityName {
            let fetchRequest = NSFetchRequest<BaseEntity>(entityName: entity)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performFetch()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !tableView.isEditing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Select" {
            let destination = segue.destination as! CoreDataDetailsViewController
            destination.object = fetchedResultsController!.object(at: tableView.indexPathForSelectedRow!)
        }
        if segue.identifier == "Edit" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let destination =  destinationNavigationController.topViewController as! CoreDataEditViewController
            let indexPath = sender as! IndexPath
            destination.object = fetchedResultsController!.object(at: indexPath)
        }
    }
    
    func performFetch() {
        if let resultsController = fetchedResultsController {
            //TODO: manage errors
            try! resultsController.performFetch()
        }
    }
    
    //MARK: NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            break
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
            break
        case .move:
            if indexPath == newIndexPath {
                tableView.reloadRows(at: [indexPath!], with: .automatic)
            } else {
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
            }
            break
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    //MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let results = fetchedResultsController, let sections = results.sections {
            return sections.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = fetchedResultsController, let sections = results.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let results = fetchedResultsController {
            let object = results.object(at: indexPath)
            cell.textLabel?.text = object.name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteRowAction = UITableViewRowAction(style: .default, title: "Delete") { (rowAction, indexPath) in
            if let results = self.fetchedResultsController {
                let object = results.object(at: indexPath)
                self.showDeleteConfirmationDialogForObject(object)
            }
        }
        let editRowAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            self.performSegue(withIdentifier: "Edit", sender: indexPath)
        }
        return [deleteRowAction, editRowAction]
    }
    
    func showDeleteConfirmationDialogForObject(_ object: BaseEntity) {
        let alertController = UIAlertController(title: "Warning", message: "Delete \(object.name!)?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.tableView.setEditing(false, animated: true)
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.managedObjectContext.delete(object)
            try! self.managedObjectContext.save()
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

protocol CoreDataTableViewControllerDelegate {
    
}
