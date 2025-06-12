//
//  transcationsModel.swift
//  Income App
//
//  Created by Rahul Shah on 17/05/25.
//

import Foundation
import SwiftUI


struct TranscationsModel : Identifiable, Hashable {
    let id =  UUID()
    let name : String
    let type : TransactionType
    let date : Date
    let amount : Double
    
    var displayDate : String {
     let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
        
    }
    
   
    
    func displayAmount(currency : Currency) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    
}
