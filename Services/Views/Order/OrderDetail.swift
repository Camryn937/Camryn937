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
//  OrderDetail.swift
//  Services
//
//  Created by Camryn Crowder on 10/25/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI

struct OrderDetail: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Group {
                        VStack {
                            RoundedRectangle(cornerRadius: 6)
                                .foregroundColor(Color("Primary"))
                                .shadow(color: Color("Shadow"), radius: 2, x: 0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0)
                                .shadow(color: Color(red: 0.863, green: 0.863, blue: 0.863), radius: 2, x: 3, y: 3)
                                .shadow(color: Color(red: 0.944, green: 0.949, blue: 0.958), radius: 2, x: -3, y: -3)
                                .frame(width: geometry.size.width - 50, height: 180)
                        }.padding(.vertical)
                    }
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Summary")
                                .font(.system(size: 20.0, weight: .semibold, design: .rounded))
                                .padding(.bottom)
                            Text("Laundry")
                                .font(.system(size: 18.0, weight: .regular, design: .rounded))
                        }
                        Spacer()
                    }.padding(.horizontal)
                    
                    Seperator()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Payment")
                                    .font(.system(size: 20.0, weight: .bold, design: .rounded))
                                    .padding(.vertical)
                                Text("$27.16")
                                    .font(.system(size: 16.0, weight: .black, design: .rounded))
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        Divider()
                            .padding(.leading)
                        Group {
                            Text("6559")
                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                .padding(.top)
                            Text("Your payment method has already been charged. Changing profiles here will not affect the payment method used for this ride")
                                .font(.system(size: 14.0, weight: .light, design: .rounded))
                                .lineLimit(3)
                                .frame(height: 80, alignment: .center)
                        }
                        .padding(.horizontal)
                        
                        Seperator()
                        Group {
                            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                                HStack {
                                    Text("Get help")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding(.vertical, 5.0)
                            }
                            Divider()
                            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                                HStack {
                                    Text("Contact")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding(.vertical, 5.0)
                            }
                        }
                        .padding(.horizontal)
                        Seperator()
                    }
                }
                .padding(.bottom)
            }
            .foregroundColor(Color("Text"))
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            .background(Color("Primary"))
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct OrderDetail_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetail()
    }
}
