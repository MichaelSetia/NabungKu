//
//  UserData.swift
//  NabungKu
//
//  Created by Michael on 13/02/26.
//

import Foundation
import SwiftData

@Model
class UserData : Identifiable {
    
    var id: UUID
    var Salary : Double
    var ReminingBudget : Double
    var PercentageSaving : Double


    init(Salary: Double, ReminingBudget: Double, PercentageSaving: Double) {
        self.id = UUID()
        self.Salary = Salary
        self.ReminingBudget = ReminingBudget
        self.PercentageSaving = PercentageSaving
    }
}

