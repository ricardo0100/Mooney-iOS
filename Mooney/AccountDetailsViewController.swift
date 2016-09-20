//
//  AccountDetailsViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 29/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class AccountDetailsViewController: CoreDataDetailsViewController, CoreDataDetailViewControllerDelegate, UITableViewDataSource {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var extractTableView: UITableView!
    
    var transactions: [Transaction] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        extractTableView.dataSource = self
    }
    
    //MARK: CoreDataDetailViewControllerDelegate
    
    func reloadViewDataWithObject(object: BaseEntity) {
        if let account = object as? Account {
            accountNameLabel.text = account.name
            totalLabel.text = "\(account.sumOfAllTransactions().toCurrencyString())"
            updateExtractLabel()
        }
    }
    
    func updateExtractLabel() {
        transactions = (object as! Account).transactionsArray()
        extractTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Extract Transaction", forIndexPath: indexPath) as! ExtractTransactionTableViewCell
        cell.nameLabel.text = transactions[indexPath.row].name
        let value = transactions[indexPath.row].value as NSDecimalNumber?
        cell.valueLabel.text = "\(value!.toCurrencyString())"
        return cell
    }

}
