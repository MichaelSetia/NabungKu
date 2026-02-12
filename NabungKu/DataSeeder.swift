//
//  DataSeeder.swift
//  NabungKu
//
//  Created by Michael on 09/02/26.
//

import Foundation
import SwiftData
import Foundation

class DataSeeder {
    static func seedData(context: ModelContext) {
        
        // 1. Buat CategoryTransaction (Kategori)
        let categories = [
            CategoryTransaction(name: "Makanan & Minuman", icon: "fork.knife"),
               CategoryTransaction(name: "Transportasi", icon: "car.fill"),
               CategoryTransaction(name: "Belanja", icon: "bag.fill"),
               CategoryTransaction(name: "Hiburan", icon: "gamecontroller.fill"),
               CategoryTransaction(name: "Gaji & Pendapatan", icon: "dollarsign.circle.fill"),
               CategoryTransaction(name: "Tabungan", icon: "creditcard.fill"),
               CategoryTransaction(name: "Tagihan", icon: "doc.fill"),
               CategoryTransaction(name: "Kesehatan", icon: "heart.fill"),
               CategoryTransaction(name: "Pendidikan", icon: "book.fill"),
               CategoryTransaction(name: "Lain-lain", icon: "ellipsis.circle.fill")
        ]
        
        categories.forEach { context.insert($0) }
        
        // 2. Buat TransactionData dengan relasi yang benar
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let transactions = [
            TransactionData(
                name: "Nasi Goreng Malam",
                amount: 25000.0,
                date: dateFormatter.date(from: "2024-01-15") ?? Date(),
                isFixedTransaction: .NotFixed,
                categoryID: categories[0]  // Makanan & Minuman
            ),
            TransactionData(
                name: "Gojek ke Kantor",
                amount: 35000.0,
                date: dateFormatter.date(from: "2024-01-15") ?? Date(),
                isFixedTransaction: .Fixed,
                categoryID: categories[1]  // Transportasi
            ),
            TransactionData(
                name: "Gaji Januari",
                amount: 10_000_000.0,
                date: dateFormatter.date(from: "2024-01-05") ?? Date(),
                isFixedTransaction: .Fixed,
                categoryID: categories[4]  // Gaji & Pendapatan
            ),
            TransactionData(
                name: "Belanja Bulanan",
                amount: 1_200_000.0,
                date: dateFormatter.date(from: "2024-01-10") ?? Date(),
                isFixedTransaction: .Fixed,
                categoryID: categories[2]  // Belanja
            ),
            TransactionData(
                name: "Netflix Subscription",
                amount: 109_000.0,
                date: dateFormatter.date(from: "2024-01-01") ?? Date(),
                isFixedTransaction: .Fixed,
                categoryID: categories[3]  // Hiburan
            ),
            TransactionData(
                name: "Transfer Tabungan",
                amount: 2_500_000.0,
                date: dateFormatter.date(from: "2024-01-06") ?? Date(),
                isFixedTransaction: .Fixed,
                categoryID: categories[5]  // Tabungan
            )
        ]
        
        transactions.forEach { context.insert($0) }
        
        print("✅ Data seeded successfully!")
        print("📁 Created \(categories.count) categories")
        print("💰 Created \(transactions.count) transactions")
        
        for (index, category) in categories.enumerated() {
            if let categoryTransactions = category.transaction {
                print("📊 Category '\(category.name)': \(categoryTransactions.count) transactions")
            }
        }
    }
    
    static func clearAllData(context: ModelContext) {
        do {
            try context.delete(model: TransactionData.self)
            try context.delete(model: CategoryTransaction.self)
            print("🗑️ All data cleared successfully!")
        } catch {
            print("❌ Error clearing data: \(error)")
        }
    }
}
