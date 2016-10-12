//
//  CategoryDetailsViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 29/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class CategoryDetailsViewController: CoreDataDetailsViewController, CoreDataDetailViewControllerDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var extractTableView: UITableView!
    
    var transactions: [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.extractTableView.dataSource = self
    }
    
    //MARK: CoreDataDetailViewControllerDelegate
    
    func reloadViewDataWithObject(_ object: BaseEntity) {
        if let category = object as? Category {
            categoryNameLabel.text = category.name
            totalLabel.text = "\(category.sumOfAllTransactions().toCurrencyString())"
            updateExtractLabel()
        }
    }
    
    func updateExtractLabel() {
        transactions = (object as! Category).transactionsArray()
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
