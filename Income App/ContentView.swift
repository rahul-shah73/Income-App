//
//  ContentView.swift
//  Income App
//
//  Created by Rahul Shah on 17/05/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var transaction :[TranscationsModel] = [
        TranscationsModel(name: "Apple Buy",type: .expense, date: Date(), amount: 5.50),
        TranscationsModel(name: "Salary",type: .income, date: Date(), amount: 2.50)
        
    ]
    var body: some View {
      
        VStack{
            
            List{
                
                ForEach(transaction ){
                    transaction in
                    VStack{
                        HStack{
                            Spacer()
                            Text("17/05/2025")
                                .font(.system(size: 14, weight : .light))
                               Spacer()
                        }
                        .padding(.vertical, 5)
                        .background(Color.grayShade.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        HStack{
                            
                            Image(systemName : transaction.type == .income ? "arrow.down.forward" : "arrow.up.forward")
                                .font(.system(size: 20, weight : .bold))
                                .foregroundStyle(transaction.type == .income ? .green : .red)
                            
                            
                            VStack(alignment: .leading, spacing: 2){
                                HStack{
                                    Text(transaction.name)
                                    Spacer()
                                    Text(String(transaction.amount))
                                    
                                }
                                
                                
                                Text("Completed")
                                Spacer()
                                
                                
                            }
                            
                        }
                    }
                    
                    
                }
            }
        }
      
                
             
         
    }
}

#Preview {
    ContentView()
}
