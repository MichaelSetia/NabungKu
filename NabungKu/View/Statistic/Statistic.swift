//
//  Statistic.swift
//  NabungKu
//
//  Created by Michael on 10/02/26.
//

import SwiftUI
import Charts
struct Statistic: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel : StatistikViewModel?
    var body: some View {
        ScrollView{
            if let viewModel = viewModel {
                HStack{
                    chartTrend(viewModel: viewModel)
                        .frame(width: .infinity, height: 100)
                }
            }
            
        }
        .task {
            viewModel = StatistikViewModel(modelContext: modelContext)
        }
        .navigationTitle(Text("Statistic"))
        .toolbar {
            
        }
        .padding()
    }
    
}


struct chartTrend : View {
    let viewModel : StatistikViewModel
    var body: some View {
        Chart(viewModel.MonthlyExpenses){ item in
            BarMark(
                x: .value("bulan", item.monthName),
                y: .value("Rp" ,item.amounth),
            )
        }
        .chartXAxis{
            AxisMarks(position: .bottom){ value in
                AxisGridLine()
                    .foregroundStyle(.clear)
                AxisTick()
                    .foregroundStyle(.clear)
                AxisValueLabel()
                    .foregroundStyle(.black)
            }
        }
        .chartYAxis{
            AxisMarks(position: .leading){ value in
                AxisGridLine()
                    .foregroundStyle(.black)
                AxisTick()
                    .foregroundStyle(.black)
                AxisValueLabel()
                    .foregroundStyle(.black)
            }
        }
        .frame(height: 300)
    }
}

#Preview {
    Statistic()
}
