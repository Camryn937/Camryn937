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
//
//  PaymentList.swift
//  Services
//
//  Created by Camryn Crowder on 11/3/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI

struct PaymentList: View {
    @State var cards = [PaymentMethods?]()
    var body: some View {
        ScrollView {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    PaymentMethodView(cards: $cards)
                    VStack(alignment: .leading) {
                        
                        Text("Account Credits")
                            .font(.system(size: 18.0, weight: .bold, design: .rounded))
                            .padding(.vertical)
                        Text("Your USD credit will be automatically applied to your next order.")
                            .lineLimit(nil)
                            .foregroundColor(Color("Sub-Text"))
                            .font(.system(size: 14.0, weight: .regular, design: .rounded))
                            .padding(.bottom)
                        
                        Group {
                            VStack {
                                Text("$0.00 USD")
                                    .font(.system(size: 18.0, weight: .medium, design: .rounded))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            NetworkController.shared.loadData(from: "http://localhost:8000/my/paymentmethods/", for: [PaymentMethods].self, using: .get) { data in
                switch data {
                case .success(let data):
                    print("Success")
                    cards = data
                    
                default:
                    print("error xx")
                }
            }
    }
    }
}

struct PaymentList_Previews: PreviewProvider {
    static var previews: some View {
        PaymentList()
    }
}
