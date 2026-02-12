//
//  ContentView.swift
//  NabungKu
//
//  Created by Michael on 03/02/26.
//

import SwiftUI
import SwiftData


enum Tab{
    case home
    case statics
}
struct ContentView: View {
    @State private var selectedTab: Tab = .home
    var body: some View {
        TabView(selection: $selectedTab){
            NavigationStack{
                Home()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.purple.opacity(0.6), .gray.opacity(0.2)]), // Contoh perpaduan warna
                            startPoint: .top,
                            endPoint: .center
                        )
                        .ignoresSafeArea()
                    )
            }
            .tabItem{ Label("Home", systemImage: "house.fill")}
            .tag(Tab.home)
            
            NavigationStack{
                Statistic()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.purple.opacity(0.6), .gray.opacity(0.2)]), // Contoh perpaduan warna
                            startPoint: .top,
                            endPoint: .center
                        )
                        .ignoresSafeArea()
                    )
            }
            .tabItem{ Label("Statistics", systemImage: "chart.bar.horizontal.page.fill")}
            .tag(Tab.statics)
        }
        .accentColor(Color.purple)
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for:[TransactionData.self, CategoryTransaction.self])
}
