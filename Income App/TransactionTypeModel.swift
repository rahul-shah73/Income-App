//
//  TransactionTypeModel.swift
//  Income App
//
//  Created by Rahul Shah on 17/05/25.
//

import Foundation
enum TransactionType: String, CaseIterable, Identifiable{
    case expense, income
    
    var id : Self {self}
    
    var title : String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
