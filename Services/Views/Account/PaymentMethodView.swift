/// Copyright (c) 2020 Capsule LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///

import SwiftUI

struct PaymentMethodView: View {
    @Binding var cards: [PaymentMethods?]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            ForEach(0..<cards.count, id:\.self) { i in
                VStack(alignment: .leading, spacing: 0.0) {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        Image(systemName: "creditcard")
                            .padding([.bottom], 4.0)
                            .padding([.trailing], 14.0)
                        Text("\(cards[i]?.brand ?? "") Ending in \(cards[i]?.last4 ?? "")")
                            .font(.system(size: 18.0, weight: .medium, design: .rounded))
                        Spacer()
                        if ((cards[i]?.isDefault) != nil) {
                            Image(systemName: "checkmark")
                                .padding(.trailing)
                        }
                    }
                    .padding(.vertical, 14.0)
                    Divider()
                }
                .padding([.leading, .bottom])
            }.onDelete(perform: { indexSet in
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            })
            
            Group {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add New Card...")
                            .font(.system(size: 16.0, weight: .medium, design: .rounded))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.top, .leading, .bottom])
                }
            }
        }
    }
}

struct paymentViewWrapper: View {
    @State var payment = [PaymentMethods?]()
    var body: some View {
        PaymentMethodView(cards: $payment)
    }
}
struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        paymentViewWrapper()
    }
}
