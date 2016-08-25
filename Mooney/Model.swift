//
//  ModelHelpers.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 18/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class Model {
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func createCategoryExample() -> Category {
        let entity =  NSEntityDescription.entityForName("Category", inManagedObjectContext:app.managedObjectContext)
        let category = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: app.managedObjectContext) as! Category
        category.name = "Supermarket"
        try! app.managedObjectContext.save()
        return category
    }
    
    func createAccountExample() -> Account {
        let entity =  NSEntityDescription.entityForName("Account", inManagedObjectContext:app.managedObjectContext)
        let account = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: app.managedObjectContext) as! Account
        account.name = "Sirius Bank"
        try! app.managedObjectContext.save()
        return account
    }
    
    func createTransactionExample() {
        let entity =  NSEntityDescription.entityForName("Transaction", inManagedObjectContext:app.managedObjectContext)
        let transaction = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: app.managedObjectContext) as! Transaction
        transaction.name = "Food for the week"
        transaction.value = 24.99
        transaction.category = createCategoryExample()
        transaction.account = createAccountExample()
        try! app.managedObjectContext.save()
    }
    
}
