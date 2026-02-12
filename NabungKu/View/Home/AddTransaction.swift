//
//  AddTransaction.swift
//  NabungKu
//
//  Created by Michael on 11/02/26.
//

import SwiftUI
import SwiftData

enum Category: String, Identifiable {
    case food, transport, entertainment, other
    var id: String { self.rawValue }
}

struct AddTransaction: View {
    @Environment(\.dismiss) var dismiss
    @Query private var category: [CategoryTransaction]
    @State var amount: Double = 0
    @State var name: String = ""
    @State var categotry: Category?
    @State var buttonSelect : Bool = false
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        VStack{
            TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(Font.largeTitle)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
            
            TextField("Name", text: $name)
                .padding(15)
                .background(.thinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 1))
                )
                
                .cornerRadius(10)
                .padding()

            ForEach(category){item in
                Button{
                    buttonSelect.toggle()
                } label: {
                    Image(systemName: "\(item.icon)")
                    Text("\(item.icon)")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .tint(Color(.red))
                .overlay{
                    Capsule()
                        .stroke(Color.blue, lineWidth: buttonSelect ? 0 : 2)
                }
            }
                
            
            
            
        }
            .toolbar{
                ToolbarItem(placement: .cancellationAction) {
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
    }
    
}

#Preview {
    AddTransaction()
}
