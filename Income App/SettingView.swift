//
//  SettingView.swift
//  Income App
//
//  Created by Rahul Shah on 08/06/25.
//

import SwiftUI

struct SettingView: View {
    @State private var orderDescinding = false
    var body: some View {
        List{
            HStack{
              (Toggle(isOn: $orderDescinding, label: {
                    Text(" Order ( \(orderDescinding ? "Earlier" : "Latest" ))")
                }))
            }
            
        }
    }
}

#Preview {
    SettingView()
}
