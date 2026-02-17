//
//  Component.swift
//  NabungKu
//
//  Created by Michael on 13/02/26.
//

import SwiftUI
import WrappingHStack
import SwiftData

struct Component: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


struct CardExpense: View {
    var title: String = "Title"
    var description : String = "Description"
    var amount: Double = 10000
    var icon : String = "creditcard"
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


struct CustomTextField : View {
    @Binding var name : String
    var title : String
    var body :some View{
        VStack(alignment: .leading, spacing: 4){
            Text("\(title)")
            //                    .font(.caption)
                .foregroundStyle(.secondary)
            TextField("\(title)", text: $name)
                .padding(12)
                .background(.thinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 0.1))
                )
                .textFieldStyle(.automatic)
                .cornerRadius(10)
            
        }
    }
}





struct CustomNumberField : View {
    @Binding var amount : Double
    let title : String
    var body :some View{
        VStack(alignment:.center){
            TextField("\(title)", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(Font.largeTitle)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .bold()
            Text("\(title)")
                .multilineTextAlignment(.center)
        }
    }
}


struct BugetBar : View {
    var currentSpending : Double
    var bugetLimit : Double
    
    private var progres : Double{
        guard bugetLimit > 0 else { return 0 }
        return min(currentSpending/bugetLimit,1.0)
    }
    
    private var progresColor : Color{
        if progres < 0.7 {
            return .green
        }
        else if progres < 0.9{
            return .yellow
        }
        else{
            return.red
        }
    }
    
    
    var body: some View {
        VStack{
            GeometryReader{ geo in
                ZStack(alignment: .leading){
                   RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray6))
                        .frame(height: 40)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(progresColor)
                        .frame(width: geo.size.width * progres, height : 40)
                        
                }
            }
        }
    }
}


#Preview {
    VStack{
        Component()
        CustomTextField(name: .constant(""), title: "")
        CustomNumberField(amount: .constant(0), title: "")
        CardExpense()
        BugetBar(currentSpending: 2000000, bugetLimit: 20000000)
    }
    .padding()
}
