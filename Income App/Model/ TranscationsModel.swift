//
//  transcationsModel.swift
//  Income App
//
//  Created by Rahul Shah on 17/05/25.
//

import Foundation
import SwiftUI
import SwiftData

@Model class TransactionModel {
    var id : UUID
    var name : String
    var  type : TransactionType
    var date : Date
    var amount : Double
    
    init(id : UUID, name: String, type: TransactionType, date: Date, amount: Double){
        
        self.id = UUID()
        self.name = name
        self.type = type
        self.date = date
        self.amount = amount

    }
    
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
