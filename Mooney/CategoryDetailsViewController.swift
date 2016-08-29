//
//  CategoryDetailsViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 29/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class CategoryDetailsViewController: UIViewController {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    var categoryModel: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let category = categoryModel {
            categoryNameLabel.text = category.name
        }
    }
}
