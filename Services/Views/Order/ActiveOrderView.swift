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
//  ActiveOrderView.swift
//  Services
//
//  Created by Camryn Crowder on 11/15/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI

struct ActiveOrderView: View {
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                Image("placeholder-image")
                    .resizable()
                    .background(Color.gray)
                    .cornerRadius(7.0)
                Text("McDonalds")
                    .font(.system(size: 18.0, weight: .regular, design: .rounded))
                Text("Preparing your order")
                    .font(.system(size: 18.0, weight: .regular, design: .rounded))
                    .padding(.vertical, 1.0)
                Text("Arrives in 10-20 min")
                    .font(.system(size: 18.0, weight: .regular, design: .rounded))
                HStack {
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        HStack {
                            Text("View Order")
                            .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                .padding(.horizontal, 4.0)
                            .foregroundColor(.blue)
                        }
                    }
                }
            }
            .foregroundColor(Color("Default-Text"))
            .padding(.all)
            .frame(height: 320, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.white)
            .cornerRadius(7.0)
            .shadow(color: Color(red: 0.863, green: 0.863, blue: 0.863), radius: 2, x: 3, y: 3)
            .shadow(color: Color(red: 0.944, green: 0.949, blue: 0.958), radius: 2, x: -3, y: -3)
        }
    }
}

struct ActiveOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveOrderView()
    }
}
