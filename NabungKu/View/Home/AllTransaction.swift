//
//  AllTransaction.swift
//  NabungKu
//
//  Created by Michael on 10/02/26.
//

import SwiftUI
import SwiftData

struct AllTransaction: View {
    @Query(sort: \TransactionData.date, order: .reverse) var transactions: [TransactionData]
    var body: some View {
        ScrollView{
            VStack{
                ForEach(transactions) { item in
                    CardExpense(title: item.name, description: item.category?.name ?? "", amount: item.amount,icon: item.category?.icon ?? "house")
                }
            }
            .padding()
            
        }
        .navigationTitle("All Transaction")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.6), .gray.opacity(0.2)]), // Contoh perpaduan warna
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
        )
        
    }
}

#Preview {
    AllTransaction()
}
