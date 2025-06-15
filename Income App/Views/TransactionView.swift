//
//  TransactionView.swift
//  Income App
//
//  Created by Rahul Shah on 18/05/25.
//

import SwiftUI
struct TransactionView: View {
    let transaction : TransactionItem
    @AppStorage("currency") var currency: Currency = .ruppee
    
   
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text(transaction.wrappedDate)
                    .font(.system(size: 14, weight : .light))
                Spacer()
            }
            .padding(.vertical, 5)
            .background(Color.grayShade.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            HStack{
                
                Image(systemName : transaction.transactionType == .income ? "arrow.down.forward" : "arrow.up.forward")
                    .font(.system(size: 20, weight : .bold))
                    .foregroundStyle(transaction.transactionType == .income ? .green : .red)
                
                
                VStack(alignment: .leading, spacing: 2){
                    HStack{
                        Text(transaction.WrappedTitle)
                        Spacer()
                        Text(String(transaction.display(currency: currency)))
                        
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
    TransactionView(transaction : TransactionItem())
}
