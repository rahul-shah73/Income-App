//
//  SettingView.swift
//  Income App
//
//  Created by Rahul Shah on 08/06/25.
//

import SwiftUI

struct SettingView: View {
    @State private var orderDescinding = false
    
    @State private var currency: Currency = .ruppee
    @State private var filterMin = 0.0
    
    var numberFormatter : NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
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
                TextField("", value: $filterMin, formatter: NumberFormatter())
            }
            .multilineTextAlignment(.trailing)
            
        }
    }
}

#Preview {
    SettingView()
}
