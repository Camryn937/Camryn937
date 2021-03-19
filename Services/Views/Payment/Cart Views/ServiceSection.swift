//
//  ServiceSection.swift
//  Services
//
//  Created by Camryn on 3/18/21.
//

import SwiftUI

struct ServiceSection: View {
    let itemsInCart: [CartItem]
    @Binding var isSelected: Bool
    @ObservedObject var order: Order
    
    var body: some View {
        Section(header: Text("Services")
            .font(.system(size: 14.0, weight: .medium, design: .rounded))) {
            
            if itemsInCart.count > 0 {
                ForEach(itemsInCart, id: \.self) { item in
                    
                    OrderItemView(isSelected: $isSelected, order: order, itemHeader: item.serviceItem, selectedItems: item.choices)
                }
            }
            else {
                Text("No Items In Cart")
            }
        }
        
    }
}

struct ServiceSection_Previews_wrapper: View {
    @State var isSelected = false
    var body: some View {
        ServiceSection(itemsInCart: [], isSelected: $isSelected, order: Order())
    }
}

struct ServiceSection_Previews: PreviewProvider {
    static var previews: some View {
        ServiceSection_Previews_wrapper()
    }
}
