//
//  TransactionDetailsViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 22/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class TransactionDetailsViewController: CoreDataDetailsViewController, CoreDataDetailViewControllerDelegate {

    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var transactionAccountLabel: UILabel!
    @IBOutlet weak var transactionCategoryLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    //MARK: CoreDataDetailViewControllerDelegate
    
    func reloadViewDataWithObject(object: BaseEntity) {
        if let transaction = object as? Transaction {
            transactionNameLabel.text = transaction.name
            transactionAccountLabel.text = accountTextForTransaction(transaction)
            transactionCategoryLabel.text = transaction.category?.name
            transactionValueLabel.text = transaction.value?.toCurrencyString()
        }
    }
    
    func accountTextForTransaction(transaction: Transaction) -> String {
        let type = TransactionTypes.fromString(transaction.type!)
        return "\(type.rawValue) in \(transaction.account!.name!)"
    }
    
}
