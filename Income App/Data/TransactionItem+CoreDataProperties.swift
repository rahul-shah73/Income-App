//
//  TransactionItem+CoreDataProperties.swift
//  Income App
//
//  Created by Rahul Shah on 11/06/25.
//
//

import Foundation
import CoreData


extension TransactionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionItem> {
        return NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var type: Int16

}

extension TransactionItem : Identifiable {

}

extension TransactionItem {
    
    var wrappedId : UUID{
        return id!
    }
    
    var WrappedTitle : String{
        return title ?? ""
    }
    
    var WrappedAmount : Double{
        return amount
    }
    
    var displayDate : Date {
        return date ?? Date()
    }
    
    var wrappedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: displayDate)
    }
    
    var transactionType : TransactionType{
        return TransactionType(rawValue: Int(type))!
        
    }
    func display(currency: Currency) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: amount as NSNumber) ?? ""
    }
}
