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
//  Landing.swift
//  Services
//
//  Created by Camryn on 10/25/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI

struct Landing: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottom) {
                    HStack {
                        Group {
                            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                                Text("Sign In")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45, maxHeight: 50, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(8.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 0.5)
                                    )
                            }}
                            .padding(.leading)
                            .frame(width: geometry.size.width / 2 , alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Group {
                            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                                Text("Get Started")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45, maxHeight: 50, alignment: .center)
                                    .background(Color.blue)
                                    .cornerRadius(8.0)
                            }
                        }
                        .padding(.trailing)
                        .frame(width: geometry.size.width / 2 , alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
        }
    }
}

struct Landing_Previews: PreviewProvider {
    static var previews: some View {
        Landing()
    }
}
