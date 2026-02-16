//
//  Component.swift
//  NabungKu
//
//  Created by Michael on 13/02/26.
//

import SwiftUI
import WrappingHStack

struct Component: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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



#Preview {
    Component()
}
