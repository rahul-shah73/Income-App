//
//  AddTransactionView.swift
//  Income App
//
//  Created by Rahul Shah on 18/05/25.
//

import SwiftUI
import SwiftData


struct AddTransactionView: View {
    
  
    
    @Environment(\.dismiss) var dismiss
    @State var amount : Double  = 0.00
    
    @State var transactionType : TransactionType = .expense
    @State var transactionTitle : String = ""
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var showAlert : Bool = false
    
   // @Binding var transactions : [TranscationsModel]
    
    @AppStorage("currency") var currency: Currency = .ruppee
    
  @Environment(\.managedObjectContext) var viewContext
    @Environment(\.modelContext) private var context
    
    
    var transactionToEdit : TransactionModel?
    
    var numberFormatter : NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter : numberFormatter)
                .font(.system(size: 50, weight : .light))
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 4)
                .padding(.horizontal)
            
            
            Picker("Choos Transaction Type", selection: $transactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size : 20, weight : .light))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.top)
            Button(action: {
                guard transactionTitle.count >= 2 else{
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be 2 character Long! "
                    showAlert = true
                    return
                }
                
//                let transaction = TranscationsModel(name: transactionTitle, type: transactionType, date: Date(), amount: amount)
                
                if let transactionToEdit = transactionToEdit {
                    transactionToEdit.name = transactionTitle
                    transactionToEdit.type = transactionType
                   
                    do {
                        try context.save()
                    }catch{
                        alertTitle = " Something Went Wrong!"
                        alertMessage = "Could not update the transaction right now!"
                        showAlert = true
                        return
                    }
                    
                    } else {
                        let transaction = TransactionModel(id: UUID(), name: transactionTitle, type: transactionType, date: Date(), amount: amount)
                        
                        context.insert(transaction)
                        
                        do{
                            try
                            context.save()
                        }catch {
                            alertTitle = " Something Went Wrong!"
                            alertMessage = "Could not add the transaction right now!"
                            showAlert = true
                            return
                        }
                       
                       
//                       transactions.append(transaction)
                    
                }
                
              
                dismiss()
                
            }, label: {
                Text(transactionToEdit == nil ? "Add Transaction" : "Update Transaction")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(Color.white)
                    .frame(height : 45)
                    .frame(maxWidth : .infinity)
                    .background(Color.forestGray)
                    .cornerRadius(10)
                    .padding(20)
                
                
            })
         
            Spacer()
        }
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                amount = transactionToEdit.amount
                transactionTitle = transactionToEdit.name
                transactionType = transactionToEdit.type
            }
        })
        
        .alert(alertTitle, isPresented: $showAlert) {
            Button(action: {
            }, label: {
                Text("OK")
            })
        }
            message: {
                Text(alertMessage)
            }
            
        }
    
}

#Preview {
    let previewContainer = PreviewHelper.previewContainer
   return AddTransactionView()
        .modelContainer(previewContainer)
}
