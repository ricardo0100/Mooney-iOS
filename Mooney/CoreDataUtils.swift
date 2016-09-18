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

    static func retrieveAllObjectsWithEntityName(entityName: String) -> [AnyObject] {
        let managedObjectContext = AppDelegate.sharedAppDelegate().managedObjectContext
        let fetchrequest = NSFetchRequest(entityName: entityName)
        let result = try! managedObjectContext.executeFetchRequest(fetchrequest)
        return result
    }
    
}
