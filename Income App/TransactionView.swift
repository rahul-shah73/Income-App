//
//  TransactionView.swift
//  Income App
//
//  Created by Rahul Shah on 18/05/25.
//

import SwiftUI
struct TransactionView: View {
    let transaction : TranscationsModel
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
                        Text(String(transaction.displayAmount))
                        
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
    TransactionView(transaction : TranscationsModel(name: "Apple Buy",type: .expense, date: Date(), amount: 5.50))
}
