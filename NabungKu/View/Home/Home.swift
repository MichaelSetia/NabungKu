//
//  Home.swift
//  NabungKu
//
//  Created by Michael on 10/02/26.
//

import SwiftUI
import SwiftData


enum ActiveSheet : Identifiable {
    var id : Int { hashValue }
    case addTransaction
    case settings
}

struct Home: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var transaction: [TransactionData]
    @Query private var category: [CategoryTransaction]
    @State private var isPresent : ActiveSheet?
    var body: some View {
        ScrollView{
            VStack {
                
                Button("Seed Data") {
                    DataSeeder.seedData(context: modelContext)
                }
                .buttonStyle(.glass)
                
            }
            .frame(height: 100)
            .padding(20)
            
            VStack{
                HStack{
                    Text("Recent Transaction")
                        .font(Font.title3.bold())
                    Spacer()
                    
                    NavigationLink(destination: AllTransaction(transaction: transaction)){
                        Text("See All")
                    }
                    
                }
                if transaction.isEmpty{
                    Spacer()
                    ContentUnavailableView("Kosong", systemImage:"tray", description: Text("Belum ada transaksi untuk sekarang"))
                }
                else{
                    ForEach(transaction.prefix(5)) { item in
                        CardExpense(title: item.name, description: item.date.formatted(date: .abbreviated, time:.omitted), amount: item.amount, icon: item.category?.icon ?? "house")
                    }
                }
                
            }
            .padding()
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresent = .addTransaction
                } label: {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarLeading){
                Button{
                    isPresent = .settings
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .sheet(item: $isPresent){ sheet in
            switch sheet {
            case .addTransaction:
                NavigationStack{
                    AddTransaction()
                }
            case .settings:
                NavigationStack{
                    SettingPreference()
                }
            }
            
        }
    }
}

#Preview {
    Home()
}
