//
//  TransactionDetailsViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 22/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class TransactionDetailsViewController: UIViewController {

    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var transactionAccountLabel: UILabel!
    @IBOutlet weak var transactionCategoryLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!
    
    var transactionModel: Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIWithTransaction()
    }
    
    func updateUIWithTransaction() {
        transactionNameLabel.text = transactionModel?.name
        transactionValueLabel.text = String(format: "R$ %.2f", transactionModel!.value! as Double)
        transactionAccountLabel.text = transactionModel?.account?.name
        transactionCategoryLabel.text = transactionModel?.category?.name
    }
    
}
