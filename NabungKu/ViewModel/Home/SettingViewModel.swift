//
//  SettingViewModel.swift
//  NabungKu
//
//  Created by Michael on 15/02/26.
//

import SwiftData
import SwiftUI
import Observation

@MainActor
@Observable
final class SettingViewModel {
    private (set) var user : [UserData] = []
    
    var Salary : Double = 0
    var precentage : Double = 0
    var userdata : UserData?{
        user.first
    }
    
    private let modelContext : ModelContext
    
    init(modelContex: ModelContext) {
        self.modelContext = modelContex
        self.load()
    }
    
    
    private func load(){
        let descriptor = FetchDescriptor<UserData>()
        user = try! modelContext.fetch(descriptor)
        if let user = user.first{
            Salary = user.Salary
            precentage = user.PercentageSaving
            
        }
    }
    func save(){
        if let exis = userdata{
            exis.Salary=Salary
            exis.PercentageSaving=precentage
            exis.ReminingBudget = Salary * (1 - precentage/100)
        }
        let SaveUser = UserData(Salary: Salary, ReminingBudget: 0, PercentageSaving: precentage)
        
        modelContext.insert(SaveUser)
        
        do{
           try modelContext.save()
            load()
        }catch{
            print(error)
        }
    }

    
}
