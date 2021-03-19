//
//  OrderOptionView.swift
//  Services
//
//  Created by Camryn on 3/18/21.
//

import SwiftUI

struct OrderOptionView: View {
    @Binding var willsubscribe: Bool
    @Binding var delivery: Bool
    let isDeliverable: Bool
    let isSubscribable: Bool
    
    var body: some View {
        
        Section(
            header: Text("Order Options")
                .font(.system(size: 14.0, weight: .regular, design: .rounded)),
            
            footer: Text("Subscriptions are billed monthly from initial purchase")
                .font(.system(size: 14.0, weight: .regular, design: .rounded))) {
            
            //Frequency Picker
                Picker(selection: $willsubscribe, label: Text("Picker")) {
                    Text("One Time").tag(false)
                    Text("Recurring").tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
            
                if willsubscribe {
                    Picker(selection: $delivery, label: Text("Frequency")) {
                        Text("Drop Off").tag(false)
                        Text("Delivery").tag(true)
                    }
                }
                Picker(selection: $delivery, label: Text("Delivery Choice")) {
                    Text("Drop Off").tag(false)
                    Text("Delivery").tag(true)
                }
        }
    }
}

struct OrderOptionView_Preview_Wrapper: View {
    @State var sub = true
    @State var delivery = true
    
    var body: some View {
        OrderOptionView(willsubscribe: $sub, delivery: $delivery, isDeliverable: true, isSubscribable: true)
    }
}

struct OrderOptionView_Previews: PreviewProvider {
    static var previews: some View {
        OrderOptionView_Preview_Wrapper()
    }
}
