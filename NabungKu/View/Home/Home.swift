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
    @State private var viewModel: HomeViewModel?
    @State private var isPresent : ActiveSheet?
    var body: some View {
        ScrollView{
            VStack {
                Text("Month Expense")
                Text("\(viewModel?.currentMonthExpense ?? 0,format: .currency(code: Locale.current.currency?.identifier ?? "USA"))")
                    .font(Font.title.bold())
                
                Spacer()
                Button{
                    viewModel?.seedData()
                }label: {
                    Text("Seed")
                }
            }
            .frame(height: 30)
            .padding(20)
            
            VStack(alignment: .leading){
                Text("Monthly Budget : \(viewModel?.monthlyBuget ?? 0 , format: .currency(code: Locale.current.currency?.identifier ?? "USA"))")
                    .font(.caption)
                BugetBar(currentSpending: viewModel?.currentMonthExpense ?? 0, bugetLimit: viewModel?.budgetLimit ?? 0)
            }
            .frame(height: 50)
            .padding()
            
            VStack{
                HStack{
                    Text("Recent Transaction")
                        .font(Font.title3.bold())
                    Spacer()
                    
                    NavigationLink(destination: AllTransaction()){
                        Text("See All")
                    }
                    
                }
                if (viewModel?.transaction.isEmpty ?? true){
                    Spacer()
                    ContentUnavailableView("Kosong", systemImage:"tray", description: Text("Belum ada transaksi untuk sekarang"))
                }
                else{
                    ForEach(viewModel?.transaction ?? []) { item in
                        CardExpense(title: item.name, description: item.date.formatted(date: .abbreviated, time:.omitted), amount: item.amount, icon: item.category?.icon ?? "house")
                    }
                }
                
            }
            .padding()
        }
        .task{
            viewModel = HomeViewModel(modelContex: modelContext)
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
                    AddTransaction(viewModel: viewModel!)
                }
            case .settings:
                NavigationStack{
                    SettingPreference(viewModel : viewModel!)
                }
            }
            
        }
    }

        
}

#Preview {
    Home()
}
