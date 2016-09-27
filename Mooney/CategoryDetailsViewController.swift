//
//  CategoryDetailsViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 29/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class CategoryDetailsViewController: CoreDataDetailsViewController, CoreDataDetailViewControllerDelegate {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    //MARK: CoreDataDetailViewControllerDelegate
    
    func reloadViewDataWithObject(_ object: BaseEntity) {
        if let category = object as? Category {
            categoryNameLabel.text = category.name
        }
    }
}
