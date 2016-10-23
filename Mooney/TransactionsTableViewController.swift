//
//  ViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 17/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class TransactionsTableViewController: CoreDataTableViewController {
    
    @IBAction func sync(_ sender: AnyObject) {
        API.sharedInstance.sync()
    }
    
    override var entityName: String? {
        return "Transaction"
    }
    
}
