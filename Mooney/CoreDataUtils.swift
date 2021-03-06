//
//  ModelHelpers.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 18/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData

class CoreDataUtils {

    static func retrieveAllObjectsWithEntityName(_ entityName: String) -> [AnyObject] {
        let managedObjectContext = AppDelegate.sharedAppDelegate().managedObjectContext
        let fetchrequest = NSFetchRequest<BaseEntity>(entityName: entityName)
        let result = try! managedObjectContext.fetch(fetchrequest)
        return result
    }
    
}
