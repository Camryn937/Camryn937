//
//  OrderITemView.swift
//  Services
//
//  Created by Camryn on 3/17/21.
//

import SwiftUI

struct OrderItemView: View {
	@Binding var isSelected: Bool
	@ObservedObject var order: Order
	let itemHeader: ServiceData.ServiceItem
	@State var selectedItems = [OrderOption.Choice]()
//	var animation: Animation {
//		Animation.easeOut
//	}
	
	var body: some View {
		VStack {
			Button(action: {
				isSelected.toggle()
				order.selectedItems = selectedItems
			}) {
				HStack {
					Text("Name")
					Spacer()
					Text("Price")
					Image(systemName: "chevron.forward")
//						.rotationEffect(.degrees(isSelected ? 90 : 0))
//						.animation(animation)
				}
				.font(.system(size: 16.0, weight: .regular, design: .rounded))
			}
			.sheet(isPresented: self.$isSelected, onDismiss: order.cancel) {
			ServiceItemView(edit: true, itemHeader: itemHeader, order: order, isShown: self.$isSelected, locationId: 18)
			}			
		}
	}
}
//
//struct OrderITemView_Previews: PreviewProvider {
//	static var previews: some View {
//		OrderItemView(order: Order())
//	}
//}
