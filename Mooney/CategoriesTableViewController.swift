//
//  CategoriesTableViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 24/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class CategoriesTableViewController: CoreDataTableViewController {
    
    override var entityName: String? {
        return "Category"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Category Cell", forIndexPath: indexPath)
        if let results = fetchedResultsController {
            cell.textLabel?.text = results.objectAtIndexPath(indexPath).name
        }
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Select Category" {
            if let results = fetchedResultsController {
                let category = results.objectAtIndexPath(tableView.indexPathForSelectedRow!) as! Category
                let destination = segue.destinationViewController as! CategoryDetailsViewController
                destination.categoryModel = category
            }
        }
    }

}
