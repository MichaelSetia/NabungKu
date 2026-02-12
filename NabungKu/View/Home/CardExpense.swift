//
//  CardExpense.swift
//  NabungKu
//
//  Created by Michael on 09/02/26.
//

import SwiftUI
import SwiftData

struct CardExpense: View {
    var title: String = "Title"
    var description : String = "Description"
    var amount: Double = 10000
    var icon : String = "creditcard"
    @Query private var category: [CategoryTransaction]
    var body: some View {
        Button{
            
        }label:{
            HStack(spacing : 20){
                Image(systemName: "\(icon)")
//                    .resizable()
//                    .frame(width: 14, height: 14)
                    .foregroundColor(.primary)
                    
                VStack(alignment: .leading){
                    Text("\(title)")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    Text("\(description)")
                        .font(.caption)
                        .foregroundStyle(Color(.secondaryLabel))
                        .lineLimit(2)
                }
                Spacer()
                Text("\(amount,format: .currency(code: Locale.current.currency?.identifier ?? "USA"))")
                    .font(.callout)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity) // Perbaiki: gunakan maxWidth, bukan .infinity
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.02), radius: 5, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                    
            
        }
        
        
    }
}

#Preview {
    CardExpense()
}
