//
//  AccountDetailsViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 29/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class AccountDetailsViewController: CoreDataDetailsViewController, CoreDataDetailViewControllerDelegate {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    //MARK: CoreDataDetailViewControllerDelegate
    
    func reloadViewDataWithObject(object: BaseEntity) {
        if let account = object as? Account {
            accountNameLabel.text = account.name
        }
    }

}
