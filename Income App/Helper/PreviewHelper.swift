//
//  File.swift
//  Income App
//
//  Created by Rahul Shah on 19/06/25.
//

import Foundation
import SwiftData

@MainActor
class PreviewHelper{
    
    static var previewContainer : ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do{
            let container = try ModelContainer(for:TransactionModel.self, configurations: config)
            let transaction = TransactionModel(id: UUID(), name: "Test", type: .income, date: Date(), amount: 150)
            container.mainContext.insert(transaction)
            return container
        }catch{
            fatalError("failed to Create Model Container")
        }
        
    }()
    
}
