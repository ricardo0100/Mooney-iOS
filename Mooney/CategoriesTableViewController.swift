//
//  CategoriesTableViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 24/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class CategoriesTableViewController: UITableViewController {

    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var categories: [Category] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Category Cell", forIndexPath: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier == "Select Transaction" {
    //            if let indexPath = tableView.indexPathForSelectedRow {
    //                let selectedTransaction = accounts[indexPath.row]
    //                let viewController = segue.destinationViewController as! TransactionDetailsViewController
    //                viewController.transactionModel = selectedTransaction
    //            }
    //        }
    //    }
    
    func loadCategories() {
        let fetchRequest = NSFetchRequest(entityName: "Category")
        do {
            let results = try app.managedObjectContext.executeFetchRequest(fetchRequest)
            categories = results as! [Category]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

}
