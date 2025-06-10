//
//  SettingsView.swift
//  Income App
//
//  Created by Rahul Shah on 09/06/25.
//

import Foundation

enum Currency: Int, CaseIterable{
    
    case dollar, ruppee
    
    var title: String{
        switch self{
            
        case .dollar:
            return "USD"
        case .ruppee:
            return "₹"
        }
    }
   
    var locale : Locale{
        switch self{
        case .dollar:
            return Locale(identifier: "en_US")
        case .ruppee:
            return Locale(identifier: "en_IND")
        }
    }
}
