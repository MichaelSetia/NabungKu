//
//  NabungKuApp.swift
//  NabungKu
//
//  Created by Michael on 03/02/26.
//

import SwiftUI
import SwiftData

@main
struct NabungKuApp: App {
   
    var shareModelContainer : ModelContainer = {
        let schema = Schema([
            TransactionData.self,
            CategoryTransaction.self
        ])
        let modelConfig = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do{
            return try ModelContainer(for: schema, configurations: [modelConfig])
        }
        catch {
            fatalError("Failed to create ModelContainer, Error \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(shareModelContainer)
    }
}
