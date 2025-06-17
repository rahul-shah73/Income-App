//
//  Income_AppApp.swift
//  Income App
//
//  Created by Rahul Shah on 17/05/25.
//

import SwiftUI

@main
struct Income_AppApp: App {
    
//    let dataManager = DataManager.shared
    var body: some Scene {
        WindowGroup {
            HomeView()
//                .environment(\.managedObjectContext, dataManager.container.viewContext)
                .modelContainer(for:[
                    TransactionModel.self
                ])
        }
    }
}
