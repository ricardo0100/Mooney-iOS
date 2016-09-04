//
//  CategoriesTableViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 24/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class CategoriesTableViewController: CoreDataTableViewController {
    
    override var entityName: String? {
        return "Category"
    }
    
}
