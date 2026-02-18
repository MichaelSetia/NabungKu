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
                VStack (spacing:20){
                    VStack(alignment: .leading){
                        HStack{
                            Text("Chart")
                                .font(.title3)
                            Spacer()
                            HStack{
                                
                                legendChart(title: "Over Buget", color: .red)
                                legendChart(title: "On Buget", color: .green)
                            }
                            .foregroundColor(.primary)
                            .padding(.horizontal,5)
                            .padding(.vertical,3)
                            .background(.black.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        chartTrend(viewModel: viewModel)
                            .frame(width: .infinity, height: 200)
                        
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(15)
                    
                    VStack(alignment:.leading,spacing: 10){
                        Text("Category")
                            .font(Font.title3)
                        ForEach (viewModel.CategoryExpenses.prefix(3)){ item in
                            HStack{
                                Image(systemName: "\(item.icon)")
                                    .foregroundColor(.primary)
                                    .frame(width: 20,height: 20)
                                    
                                VStack(alignment:.leading){
                                    Text(item.name)
                                        .font(.subheadline)
                                    GeometryReader{geo in
                                        ZStack(alignment: .leading){
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color(.secondarySystemBackground))
                                                .frame(width: .infinity,height: 10)
                                            let percentage = item.budgetLimit > 0 ? min(item.total / item.budgetLimit, 1.0) : 0
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.blue)
                                                .frame(width: percentage * geo.size.width, height: 10)
                                            
                                            
                                            
                                            
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(15)
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

struct legendChart : View {
    var title : String = ""
    var color : Color = .white
    var body: some View {
        HStack(spacing:8){
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
                .padding(.top,2)
            Text(title)
                .font(Font.subheadline)
                .foregroundStyle(Color(.white))
        }
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
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(item.amounth > Int(item.budgetLimit) ? Color.red : Color.green)
            
            RuleMark(
                y : .value("Rule", item.budgetLimit)
            )
            .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
            .foregroundStyle(.orange)
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
                AxisValueLabel {
                    if let amount = value.as(Double.self) {
                        Text(abbreviatedCurrency(amount))
                    }
                }
                    
                AxisGridLine()
                    .foregroundStyle(.clear)
                AxisTick()
                    .foregroundStyle(.clear)
//                AxisValueLabel()
//                    .foregroundStyle(.black)
            }
        }
        .frame(height: 150)
    }
    
    func abbreviatedCurrency(_ value: Double) -> String {
        let billion = 1_000_000_000.0
        let million = 1_000_000.0
        let thousand = 1_000.0
        
        if value >= billion {
            return String(format: "%.1f M", value / billion)
        } else if value >= million {
            return String(format: "%.1f Jt", value / million)
        } else if value >= thousand {
            return String(format: "%.0f Rb", value / thousand)
        } else {
            return String(format: "%.0f", value)
        }
    }
}


#Preview {
    Statistic()
}
