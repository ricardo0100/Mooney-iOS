//
//  AccountsTableViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 24/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class AccountsTableViewController: CoreDataTableViewController {
    
    override var entityName: String? {
        return "Account"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Account Cell", forIndexPath: indexPath)
        if let results = fetchedResultsController {
            cell.textLabel?.text = results.objectAtIndexPath(indexPath).name
        }
        return cell
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Select Account" {
            if let results = fetchedResultsController {
                let account = results.objectAtIndexPath(tableView.indexPathForSelectedRow!) as! Account
                let destination = segue.destinationViewController as! AccountDetailsViewController
                destination.accountModel = account
            }
        }
    }
    
}
