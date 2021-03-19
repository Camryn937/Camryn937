//
//  CartTotalView.swift
//  Services
//
//  Created by Camryn on 3/18/21.
//

import SwiftUI

struct CartTotalView: View {
    var body: some View {
        Section(header: Text("Total")
        .font(.system(size: 14.0, weight: .medium, design: .rounded))) {        VStack(alignment: .leading) {
                HStack {
                    Text("Subtotal")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Text("0.00")
                }
                .padding(.vertical, 5.0)
            
                HStack {
                    Text("Fees and Estimated tax")
                    Spacer()
                    Text("0.00")
                }
                .padding(.bottom, 5.0)
                HStack {
                    Text("Delivery")
                        .fontWeight(.regular)
                    
                    Spacer()
                    Text("0.00")
                }
                .padding(.bottom, 5)
            }
        }
    }
}

struct CartTotalView_Previews: PreviewProvider {
    static var previews: some View {
        CartTotalView()
    }
}
