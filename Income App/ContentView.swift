//
//  ContentView.swift
//  Income App
//
//  Created by Rahul Shah on 17/05/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var transactions :[TranscationsModel] = [
        TranscationsModel(name: "Apple Buy",type: .expense, date: Date(), amount: 5.50),
        TranscationsModel(name: "Salary",type: .income, date: Date(), amount: 2.50)
        
    ]
    
    fileprivate  func BalanceView() -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.forestGray)
                .frame(height: 170)
                .shadow(color: .black, radius: 8, y: 8)
                .padding(10)
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        VStack{
                            Text("BALANCE")
                                .font(.system(size: 20))
                                .font(.caption)
                                .foregroundStyle(.white)
                            
                            
                            Text("₹25")
                                .font(.system(size: 42, weight: .semibold))
                                .foregroundStyle(.white)
                            
                        }
                    }
                    HStack(spacing: 35){
                        VStack(alignment: .leading){
                            Text("Expense")
                                .font(.system(size:15, weight: .semibold))
                                .foregroundStyle(Color.white)
                            
                            Text("₹20")
                                .font(.system(size:15, weight: .regular))
                                .foregroundStyle(Color.white)
                        }
                        // .padding(.horizontal,40)
                        VStack(alignment: .leading){
                            Text("Income")
                                .font(.system(size:15, weight: .semibold))
                                .foregroundStyle(Color.white)
                            
                            Text("₹50")
                                .font(.system(size:15, weight: .regular))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                .padding(.leading,20)
                Spacer()
                    
            }
        }
    }
        
    
    var body: some View {
        NavigationStack{
            VStack{
                BalanceView()
                List{
                    
                    ForEach(transactions ){
                        transaction in
                        
                        
                        Button(action:{
                            showAddTransactionView = true
                            
                        } , label:{
                            TransactionView(transaction :   transaction )
                                .foregroundStyle(Color.black)
                        })
                        
                        
                    }
                }
            }
            //.scrollDisabled(true)
            .scrollContentBackground(.hidden)
        }
      
                
             
         
    }
}

#Preview {
    ContentView()
}

