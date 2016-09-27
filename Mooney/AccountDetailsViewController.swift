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
    
    func reloadViewDataWithObject(_ object: BaseEntity) {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Extract Transaction", for: indexPath) as! ExtractTransactionTableViewCell
        cell.nameLabel.text = transactions[(indexPath as NSIndexPath).row].name
        let value = transactions[(indexPath as NSIndexPath).row].value as NSDecimalNumber?
        cell.valueLabel.text = "\(value!.toCurrencyString())"
        return cell
    }

}
