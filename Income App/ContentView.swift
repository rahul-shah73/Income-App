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
    @State var showAddTransactionView = false
    
    @State var transactionToEdit: TranscationsModel?
    
    @State var showSettingsView = false
    
    var income : String {
        var sumIncome = 0.00
        for transaction in transactions {
            if transaction.type == .income {
                sumIncome += transaction.amount
            }
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from:sumIncome as  NSNumber) ?? "0.00"
        
    }
    
    var expense : String {
        var sumExpense = 0.00
        for transaction in transactions {
            if transaction.type == .expense {
                sumExpense += transaction.amount
            }
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from:sumExpense as  NSNumber) ?? "0.00"
        
    }
    
    
    var totalBalance : String{
         var total = 0.00
        for transaction in transactions {
            switch transaction.type {
                case .income:
                total += transaction.amount
            case .expense:
                total -= transaction.amount
            }
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from:total as NSNumber) ?? "0.00"
        
    }
    
    
    
    fileprivate func FloatingButton() -> some View{
        VStack{
            NavigationLink (destination:AddTransactionView(transactions: $transactions), label: {
                Text("+")
                    .font(.system(size: 25, weight : . regular))
                    .frame(width: 75, height: 75)
                    .foregroundStyle(.white)
                
            })
            
            .background(Color.forestGray)
            .clipShape(Circle())
            
            
        }
    }
    
   
    
    
    fileprivate  func BalanceView() -> some View {
        NavigationStack{
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
                                
                                
                                Text("\(totalBalance)")
                                    .font(.system(size: 42, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                        }
                        HStack(spacing: 35){
                            VStack(alignment: .leading){
                                Text("Expense")
                                    .font(.system(size:15, weight: .semibold))
                                    .foregroundStyle(Color.white)
                                
                                Text("\(expense)")
                                    .font(.system(size:15, weight: .regular))
                                    .foregroundStyle(Color.white)
                            }
                            // .padding(.horizontal,40)
                            VStack(alignment: .leading){
                                Text("Income")
                                    .font(.system(size:15, weight: .semibold))
                                    .foregroundStyle(Color.white)
                                
                                Text("\(income)")
                                    .font(.system(size:15, weight: .regular))
                                    .foregroundStyle(Color.white)
                            }
                        }
                    }
                    .padding(.leading,20)
                    Spacer()
                    
                    //it will slides the things up
                    
                }
                
            }
            
            
        }
    }
    
     var body: some View {
        
        
         
        NavigationStack{
           
            VStack{
               
                Button(action: { showSettingsView = true}, label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .foregroundStyle(Color.gray)
                        .frame(width: 30, height: 30)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 20)
                })
               
                   
               
            }
            VStack{
                BalanceView()
                List{
                    
                    ForEach(transactions ){
                        transaction in
                      Button(action:{
                            transactionToEdit = transaction
                      } , label:{
                            TransactionView(transaction :   transaction )
                                .foregroundStyle(Color.black)
                        })
                        
                        
                    }
                    .onDelete(perform: deleteTransactions)
                }
            
                //.scrollDisabled(true)
                .scrollContentBackground(.hidden)
                FloatingButton()
            }
            
            .navigationDestination(item: $transactionToEdit, destination: { transactionToEdit in
                AddTransactionView(transactions: $transactions, transactionToEdit : transactionToEdit)
            })
            .navigationDestination(isPresented: $showAddTransactionView) {
                AddTransactionView(transactions: $transactions)
            }
            
            .navigationDestination(isPresented: $showSettingsView, destination: {
                SettingView()
            })
        }
                                   
    }
    private func deleteTransactions(at offSets : IndexSet){
        transactions.remove(atOffsets : offSets)
    }
}

#Preview {
    ContentView()
}

