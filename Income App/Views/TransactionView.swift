//
//  TransactionView.swift
//  Income App
//
//  Created by Rahul Shah on 18/05/25.
//

import SwiftUI
struct TransactionView: View {
    let transaction : TransactionModel
    @AppStorage("currency") var currency: Currency = .ruppee
    
   
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text(transaction.displayDate)
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
                        Text(String(transaction.displayAmount(currency: currency)))
                        
                    }
                    
                    
                    Text("Completed")
                    Spacer()
                    
                    
                }
                
            }
        }
        .listRowSeparator(.hidden)
    }
}

#Preview {
    TransactionView(transaction : TransactionModel(id: UUID(), name: "Apple", type: .expense, date: Date(), amount: 5.00))
}
