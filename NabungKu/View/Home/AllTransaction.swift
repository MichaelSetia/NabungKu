//
//  AllTransaction.swift
//  NabungKu
//
//  Created by Michael on 10/02/26.
//

import SwiftUI
import SwiftData

struct AllTransaction: View {
    let transaction : [TransactionData]
    var body: some View {
        ScrollView{
            VStack{
                ForEach(transaction) { item in
                    CardExpense(title: item.name, description: item.category?.name ?? "", amount: item.amount,icon: item.category?.icon ?? "house")
                }
            }
            .padding()
            
        }
        .navigationTitle("All Transaction")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    let foodCategory = CategoryTransaction(name: "Makanan", icon: "pizza")
       
       // Buat transaksi contoh
       let sampleTransactions = [
        TransactionData(name: "Nasi Goreng", amount: 25000, date: Date(), isFixedTransaction: .NotFixed, categoryID: foodCategory),
        TransactionData(name: "Gaji", amount: 5000000, date: Date(), isFixedTransaction: .Fixed, categoryID: foodCategory),
        TransactionData(name: "Bensin", amount: 50000, date: Date().addingTimeInterval(-86400), isFixedTransaction: .Fixed, categoryID: foodCategory)
       ]
    AllTransaction(transaction: sampleTransactions)
}
