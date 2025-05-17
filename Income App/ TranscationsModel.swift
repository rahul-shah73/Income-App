//
//  transcationsModel.swift
//  Income App
//
//  Created by Rahul Shah on 17/05/25.
//

import Foundation
struct TranscationsModel : Identifiable {
    let id =  UUID()
    let name : String
    let type : TransactionType
    let date : Date
    let amount : Double
    
}
