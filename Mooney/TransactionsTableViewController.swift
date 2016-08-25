//
//  ViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 17/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class TransactionsTableViewController: UITableViewController {
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var transactions: [Transaction] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTransactions()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Transaction Cell", forIndexPath: indexPath)
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = transaction.name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Select Transaction" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedTransaction = transactions[indexPath.row]
                let viewController = segue.destinationViewController as! TransactionDetailsViewController
                viewController.transactionModel = selectedTransaction
            }
        }
    }
    
    func loadTransactions() {
        let fetchRequest = NSFetchRequest(entityName: "Transaction")
        do {
            let results = try app.managedObjectContext.executeFetchRequest(fetchRequest)
            transactions = results as! [Transaction]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

}
