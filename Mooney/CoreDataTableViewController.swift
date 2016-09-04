//
//  CoreDataTableViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 28/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTableViewController: UITableViewController {
    
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
                managedObjectContext: AppDelegate.sharedAppDelegate().managedObjectContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        performFetch()
        tableView.reloadData()
    }
    
    func performFetch() {
        if let resultsController = fetchedResultsController {
            //TODO: manage errors
            try! resultsController.performFetch()
        }
    }
    
    //MARK: NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        //TODO: update changes with Insert/Delete/Update delegate methods
        tableView.reloadData()
    }
    
    //MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let results = fetchedResultsController, sections = results.sections {
            return sections.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = fetchedResultsController, sections = results.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if let results = fetchedResultsController {
            cell.textLabel?.text = results.objectAtIndexPath(indexPath).name
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Select" {
            let destination = segue.destinationViewController as! CoreDataDetailsViewController
            destination.object = fetchedResultsController!.objectAtIndexPath(tableView.indexPathForSelectedRow!) as? BaseEntity
        }
    }
    
}
