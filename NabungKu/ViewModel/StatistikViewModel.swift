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
    private(set) var CategoryExpenses : [CategoryExpense] = []
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
        let amounth : Int
        let budgetLimit : Double

        var monthName: String {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM yyyy"
                return formatter.string(from: month)
            }
    }
    
    struct CategoryExpense: Identifiable {
        let id : UUID = UUID()
        let name : String
        let icon : String
        let total : Double
        let budgetLimit : Double
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        load()
    }
    
    func load() {
        let budget = 0
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
            return MonthlyExpense( month: monthStart, amounth: Int(total), budgetLimit: budget)
        }
        
        
        
        
        let calendarNow = Calendar.current
        let now = Date()
        guard let start = calendar.date(from:calendar.dateComponents([.year,.month], from: now)), let end = calendar.date(byAdding: .month, value: 1 ,to: start)
        else{
            return
        }
        
        let transthisMonth = transactions.filter{ trans in
            trans.date >= start && trans.date < end
            
        }
        
        var categoryTotal : [String:(total:Double, icon:String, name:String)] = [:]
        
        for transaction in transthisMonth {
            let name = transaction.category?.name ?? "Other"
            let icon = transaction.category?.icon ?? "arrow.2.circlepath.circle"
            let current = categoryTotal[name] ?? (0, icon, name)
                categoryTotal[name] = (current.total + transaction.amount, icon, name)
        }
        
        let budgetcat = (users?.Salary ?? 0) * (1 - (users?.PercentageSaving ?? 0.0) / 100 ) ?? 0
        
        
            
        CategoryExpenses = categoryTotal.map{ value in
            CategoryExpense(name: value.value.name, icon: value.value.icon, total: value.value.total, budgetLimit: budgetcat)
        }
        .sorted {$0.total > $1.total}
    }
    
    
    
}
