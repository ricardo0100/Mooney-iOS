//
//  ViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 17/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class TransactionsTableViewController: CoreDataTableViewController {
    
    override var entityName: String? {
        return "Transaction"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Transaction Cell", forIndexPath: indexPath)
        if let results = fetchedResultsController {
            cell.textLabel?.text = results.objectAtIndexPath(indexPath).name
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Select Transaction" {
            let destination = segue.destinationViewController as! TransactionDetailsViewController
            destination.transactionModel = fetchedResultsController!.objectAtIndexPath(tableView.indexPathForSelectedRow!) as? Transaction
        }
    }
    
}
