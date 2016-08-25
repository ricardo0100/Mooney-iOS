//
//  AccountsTableViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 24/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class AccountsTableViewController: UITableViewController {
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var accounts: [Account] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAccounts()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Account Cell", forIndexPath: indexPath)
        let transaction = accounts[indexPath.row]
        cell.textLabel?.text = transaction.name
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
    
    func loadAccounts() {
        let fetchRequest = NSFetchRequest(entityName: "Account")
        do {
            let results = try app.managedObjectContext.executeFetchRequest(fetchRequest)
            accounts = results as! [Account]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

}
