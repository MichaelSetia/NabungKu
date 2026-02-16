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
    
    init( modelContex: ModelContext) {
        self.modelContex = modelContex
        fetchData()
    }
    
    func seedData(){
        if category.isEmpty && transaction.isEmpty{
            DataSeeder.seedData(context: modelContex)
            fetchData()
        }
        
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
        fetchData()
    }
}
