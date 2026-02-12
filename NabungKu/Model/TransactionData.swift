//
//  TransactionData.swift
//  NabungKu
//
//  Created by Michael on 03/02/26.
//

import Foundation
import SwiftData

@Model
class TransactionData {
    var id: UUID
    var name : String
    var amount : Double
    var date : Date
    var isFixedTransaction : IsFixedTransaction
    
    var category : CategoryTransaction?
    
    init(name: String, amount: Double, date: Date, isFixedTransaction: IsFixedTransaction = .Fixed, categoryID: CategoryTransaction? = nil) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.date = date
        self.isFixedTransaction = isFixedTransaction
        self.category = categoryID
    }
    
    enum IsFixedTransaction : String, Codable, CaseIterable{
        case Fixed = "Fixed"
        case NotFixed = "Not Fixed"
    }
}
