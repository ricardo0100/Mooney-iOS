//
//  ViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 17/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class TransactionsTableViewController: CoreDataTableViewController {
    
    override var entityName: String? {
        return "Transaction"
    }
    
}
