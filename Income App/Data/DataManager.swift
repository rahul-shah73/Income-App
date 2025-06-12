//
//  DataManager.swift
//  Income App
//
//  Created by Rahul Shah on 12/06/25.
//

import Foundation
import CoreData
class DataManager {
    
  let container = NSPersistentContainer(name: "IncomeData")
 static let shared = DataManager()
    init(){
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
}
