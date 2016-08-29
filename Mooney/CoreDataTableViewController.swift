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
    
    var cellIdentifier: String {
        return "Cell"
    }
    
    var fetchedResultsController: NSFetchedResultsController?
    
    let managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        if let entity = entityName {
            let fetchRequest = NSFetchRequest(entityName: entity)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: managedObjectContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        performFetch()
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        if let results = fetchedResultsController {
            cell.textLabel?.text = results.objectAtIndexPath(indexPath).name
        }
        return cell
    }
    
}
