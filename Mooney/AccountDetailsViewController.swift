//
//  AccountDetailsViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 29/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class AccountDetailsViewController: UIViewController {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    
    var accountModel: Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let account = accountModel {
            accountNameLabel.text = account.name
        }
    }

}
