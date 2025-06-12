//
//  SettingView.swift
//  Income App
//
//  Created by Rahul Shah on 08/06/25.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("orderDescinding")  var orderDescinding = false
    @AppStorage("filterMinimum") var filterMinimum = 0.0
    @AppStorage("currency") var currency: Currency = .ruppee
    @State private var filterMin = 0.0
    
    @Environment(\.dismiss) var dismiss
    var numberFormatter : NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
    
    
    var body: some View {
        List{
            HStack{
              (Toggle(isOn: $orderDescinding, label: {
                    Text(" Order (\(orderDescinding ? "Earlier" : "Latest"))")
                }))
            }
            HStack{
                Picker("currency", selection: $currency){
                    ForEach(Currency.allCases, id: \.self ){
                        currency in
                        Text(currency.title)
                        
                    }
                }
            }
            HStack{
                Text("Filter Minimum")
                TextField("", value: $filterMin, formatter: numberFormatter)
            }
            .multilineTextAlignment(.trailing)
            
        }
        Spacer()
        Button {
            dismiss()
        } label: {
            Text("Apply Filter")
              
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .bold))
                .padding (10)
                
                .background(Color.blue)
                
                .clipShape(RoundedRectangle(cornerRadius: 10))
               
        }

       
      
    }
}

#Preview {
    SettingView()
}
