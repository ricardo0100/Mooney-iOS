//
//  BaseEntity.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 29/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData


class BaseEntity: NSManagedObject {
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        creation = Date()
        update = Date()
        uuid = NSUUID().uuidString
    }
    
}
