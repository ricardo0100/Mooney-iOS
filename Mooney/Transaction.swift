//
//  Transaction.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 29/08/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import CoreData


class Transaction: BaseEntity {

    override func awakeFromInsert() {
        super.awakeFromInsert()
        type = TransactionTypes.Debit.rawValue
    }

}
