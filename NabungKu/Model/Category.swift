//
//  Untitled.swift
//  NabungKu
//
//  Created by Michael on 03/02/26.
//
import Foundation
import SwiftData

@Model
class CategoryTransaction {
    var id: UUID
    var name: String
    var icon : String?
    
    @Relationship(inverse: \TransactionData.category)
    var transaction : [TransactionData]?
    
    init( name: String, icon: String?) {
        self.id = UUID()
        self.name = name
        self.icon = icon
        
    }
}
