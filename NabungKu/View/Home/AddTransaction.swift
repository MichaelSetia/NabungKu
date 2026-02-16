//
//  AddTransaction.swift
//  NabungKu
//
//  Created by Michael on 11/02/26.
//

import SwiftUI
import SwiftData
import WrappingHStack


struct AddTransaction: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel : AddTransactionViewModel?

    let columns = [GridItem(.adaptive(minimum: 80))]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            if let viewModel{
                @Bindable var viewModel = viewModel
                CustomNumberField(amount: $viewModel.amount, title: "Amount")
                
                CustomTextField(name: $viewModel.name, title: "Name")
                
                CategoryTransactions(buttonSelect: $viewModel.buttonSelect, categories: viewModel.category)

            }
            if let error = viewModel?.errorMesaage{
                Text(error)
            }
            Spacer()
            
        }
        .navigationTitle("Add Transaction")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .onAppear{
            viewModel = AddTransactionViewModel(modelcontext: modelContext)
        }
        .toolbar{
            ToolbarItem(placement: .cancellationAction) {
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button{
                    viewModel?.AddTransaction()
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
    }


}

struct CategoryTransactions: View {
    @Binding var buttonSelect: CategoryTransaction?
    let categories: [CategoryTransaction]

    var body: some View {
        VStack{
            Text("Category :")
            WrappingHStack(categories) { item in
                Button {
                    buttonSelect = item
                } label: {
                    Image(systemName: item.icon ?? "")
                    Text(item.name)
                }
                .foregroundStyle(buttonSelect?.id == item.id ? .white : .purple)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .tint(buttonSelect?.id == item.id ? .purple.opacity(0.6) : .white)
                .overlay(
                    Capsule()
                        .stroke(Color.purple.opacity(0.6), lineWidth: buttonSelect?.id == item.id ?  0 : 2)
                )
                .padding(.horizontal,2)
                .padding(.vertical,4)
            }
        }
    }
}


//#Preview {
//    AddTransaction(
//        .modelContainer(for: [TransactionData.self,CategoryTransaction.self])
//    )
//}
