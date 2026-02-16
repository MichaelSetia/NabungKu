//
//  SettingPreference.swift
//  NabungKu
//
//  Created by Michael on 11/02/26.
//

import SwiftUI
import SwiftData

struct SettingPreference: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
   @State private var viewModel: SettingViewModel?
    
    var body: some View {
            VStack(spacing:20){
                if let viewModel{
                    @Bindable var viewModel = viewModel
                    CustomNumberField(amount: $viewModel.Salary, title: "Salary")
                    VStack {
                        Text ("\(viewModel.precentage, specifier: "%.0f")%")
                        
                        HStack{
                            Text("0%")
                            Slider(value: $viewModel.precentage, in: 0...100, step: 1)
                            Text("100%")
                        }
                    }
                }
                //            Slider(value: 0...100, minimumValueLabel: 0, maximumValueLabel: 100)
                Spacer()
            }
            .padding()
            .onAppear{
                viewModel = SettingViewModel(modelContex: modelContext)
            }
            .navigationTitle("Preference")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement:.cancellationAction){
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement:.confirmationAction){
                    Button{
                        viewModel?.save()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
    }
   
}

#Preview {
    SettingPreference()
}
