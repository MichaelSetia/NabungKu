//
//  StatistikViewModel.swift
//  NabungKu
//
//  Created by Michael on 16/02/26.
//

import SwiftUI
import SwiftData
import Observation





@MainActor
@Observable
final class StatistikViewModel {
    private let modelContext: ModelContext
    
    private(set) var MonthlyExpenses : [MonthlyExpense] = []
    private(set) var trend: trend = .same
    private(set) var total: Int = 0
    
    enum trend {
        case up
        case down
        case same
    }
    
    struct MonthlyExpense: Identifiable {
        let id : UUID = UUID()
        let month : Date
        let amounth : Double
        let budgetLimit : Double
        
        var monthName: String {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM yyyy"
                return formatter.string(from: month)
            }
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        load()
    }
    
    func load() {
        let transac = FetchDescriptor<TransactionData>(sortBy: [SortDescriptor(\.date)])
        guard let transactions = try? modelContext.fetch(transac) else {
            return
        }
        
        let user = FetchDescriptor<UserData>()
        let users = try? modelContext.fetch(user).first
        
        let calendar = Calendar.current
        let group = Dictionary(grouping: transactions) { transactions -> Date in
            let component = calendar.dateComponents([.year, .month],from: transactions.date)
            return (calendar.date(from:component) ?? transactions.date)
        }
        
        let sort = group.keys.sorted()
        
        MonthlyExpenses = sort.map{ monthStart in
            let total = group[monthStart]?.reduce(0) { $0 + $1.amount } ?? 0
            let budget = (users?.Salary ?? 0) * (1 - (users?.PercentageSaving ?? 0.0) / 100 ) ?? 0
            return MonthlyExpense( month: monthStart, amounth: Double(total), budgetLimit: budget)
        }
    }
    
    
    
}
