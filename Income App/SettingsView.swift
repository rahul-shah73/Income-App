//
//  SettingsView.swift
//  Income App
//
//  Created by Rahul Shah on 09/06/25.
//


enum Currency: CaseIterable{
    
    case dollar, ruppee
    
    var title: String{
        switch self{
            
        case .dollar:
            return "USD"
        case .ruppee:
            return "₹"
        }
    }
   
    
}
