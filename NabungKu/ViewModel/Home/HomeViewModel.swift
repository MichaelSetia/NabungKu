//
//  HomeViewModel.swift
//  NabungKu
//
//  Created by Michael on 15/02/26.
//

import SwiftData
import SwiftUI
import Observation

@MainActor
@Observable
final class HomeViewModel {
    private(set) var transaction: [TransactionData] = []
    private(set) var category: [CategoryTransaction] = []
    
    var errorMessage: String?
    
    private let modelContex : ModelContext
    
    private (set) var user : [UserData] = []
    
    var Salary : Double = 0
    var precentage : Double = 0
    var userdata : UserData?{
        user.first
    }
    
    var isformValid: Bool {
        !name.isEmpty && amount != 0 && buttonSelect != nil
    }
    
    private (set) var categories : CategoryTransaction?
    var amount: Double = 0
    var name: String = ""
    var categotry: Category?
    var buttonSelect : CategoryTransaction?
    
    init( modelContex: ModelContext) {
        self.modelContex = modelContex
        load()
    }
    
    func seedData(){
        if category.isEmpty && transaction.isEmpty{
            DataSeeder.seedData(context: modelContex)
            load()
        }
        
    }
    
    var monthlyBuget: Double {
        return   budgetLimit - currentMonthExpense
    }
    
    func fetchData(Limit: Int? = 5) {
        
        do{
            var fetch = FetchDescriptor<TransactionData>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            fetch.fetchLimit = Limit
            transaction = try modelContex.fetch(fetch)
            
            var fetchCategory = FetchDescriptor<CategoryTransaction>()
            category = try modelContex.fetch(fetchCategory)
            
            errorMessage = nil
        }
        catch{
            errorMessage = "Failed to fetch data \(error.localizedDescription)"
        }
    }
    
    
    func deleteTransaction(trans : TransactionData){
        modelContex.delete(trans)
        try? modelContex.save()
        load()
    }
    
    func load(){
        let descriptor = FetchDescriptor<UserData>()
        user = try! modelContex.fetch(descriptor)
        if let user = user.first{
            Salary = user.Salary
            precentage = user.PercentageSaving
            
        }
        fetchData()
    }
    
    func save(){
        if let exis = userdata{
            exis.Salary=Salary
            exis.PercentageSaving=precentage
            exis.ReminingBudget = Salary * (1 - precentage/100)
        }
        let SaveUser = UserData(Salary: Salary, ReminingBudget: 0, PercentageSaving: precentage)
        
        modelContex.insert(SaveUser)
        
        do{
           try modelContex.save()
            load()
        }catch{
            print(error)
        }
    }
    
    var currentMonthExpense: Double{
        var currentDate = Calendar.current
        var date = Date()
        
        guard let startMonth = currentDate.date(from: currentDate.dateComponents([.month,.year], from: date)),
                let endMonth = currentDate.date(byAdding: DateComponents(month:1, day: -1), to: startMonth)
        else {
            return 0
        }
        
        return transaction
            .filter{$0.date >= startMonth && $0.date <= endMonth}.reduce(0) {$0+$1.amount}
    }
    
    var budgetLimit: Double{
        if let user = userdata{
            return user.Salary * (1 - user.PercentageSaving/100)
        }
        return 0
    }
    
    
    func AddTransaction(){
        guard isformValid else {errorMessage = "Please fill the form correctly"; return}
        
        let trans = TransactionData(name: name, amount: amount, date: Date(), categoryID: buttonSelect)
        modelContex.insert(trans)

        do {
           try modelContex.save()
            load()
            clear()
        }
        catch{
            print(error)
        }
        
    }
    
    private func clear(){
        amount = 0
        name = ""
        buttonSelect = nil
    }
}
