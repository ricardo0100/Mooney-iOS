//
//  AppDelegate.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 17/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import CoreData
import DATAStack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let dataStack = DATAStack(modelName:"Mooney")

    static func sharedAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        handleContextWillSaveNotification()
        API.sharedInstance.sync()
        return true
    }

    lazy var managedObjectContext: NSManagedObjectContext = {
        return self.dataStack.mainContext
    }()

    //TODO: move to a separate class
    func handleContextWillSaveNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.willSaveNotificationCalled(_:)), name: NSNotification.Name(rawValue: "NSManagedObjectContextWillSaveNotification"), object: nil)
    }
    
    func willSaveNotificationCalled(_ notification: Notification) {
        let context = notification.object as! NSManagedObjectContext
        let now = Date()
        
        for object in context.updatedObjects {
            (object as! BaseEntity).updatedAt = now
        }
    }

}
