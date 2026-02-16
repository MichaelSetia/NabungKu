//
//  AddTransactionModel.swift
//  NabungKu
//
//  Created by Michael on 15/02/26.
//

import SwiftUI
import SwiftData

@MainActor
@Observable
final class AddTransactionViewModel{
    private (set) var categories : CategoryTransaction?
    private (set) var category: [CategoryTransaction] = []
    var amount: Double = 0
    var name: String = ""
    var categotry: Category?
    var buttonSelect : CategoryTransaction?
    private let modelContext : ModelContext
    
    var isformValid: Bool {
        !name.isEmpty && amount != 0 && buttonSelect != nil
    }
    var errorMesaage: String?
    init(modelcontext: ModelContext) {
        self.modelContext = modelcontext
        fetchData()
    }
    
    private func fetchData(){
        var fetchs = FetchDescriptor<CategoryTransaction>()
        do{
            category = try modelContext.fetch(fetchs)
        }
        catch {
            errorMesaage = "Failed to fetch data \(error.localizedDescription)"
        }
    }
    
    func AddTransaction(){
        guard isformValid else {errorMesaage = "Please fill the form correctly"; return}
        
        let trans = TransactionData(name: name, amount: amount, date: Date(), categoryID: buttonSelect)
        modelContext.insert(trans)
        
        do {
           try modelContext.save()
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
