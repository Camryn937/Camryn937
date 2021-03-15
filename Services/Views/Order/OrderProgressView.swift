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
//  OrderProgressView.swift
//  Services
//
//  Created by Camryn Crowder on 11/4/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI

struct OrderProgressView: View {
    let status = ["Order confirmed", "Out for pickup", "Picked Up", "Completed"]
    var isCompleted = true
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 1.0) {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Arriving Friday")
                                .font(.system(size: 24.0, weight: .semibold, design: .rounded))}
                            .padding([.top, .leading])
                        Divider()
                            .padding(.bottom)
                        ForEach(status, id:\.self) { stat in
                            VStack(alignment: .leading, spacing: 11.0) {
                                HStack{
                                    
                                    Image(systemName: isCompleted ? "checkmark.square.fill" : "squareshape.fill")
                                        .resizable()
                                        .foregroundColor(Color.green)
                                        .frame(width: 25, height: 25)
                                    Text(stat)
                                        .font(.system(size: 18.0, weight: .medium, design: .rounded))
                                        .padding(.leading, 5.0)
                                }
                                if stat != status[status.count-1] {
                                    ForEach(0..<3) { _ in
                                        Group {
                                            Rectangle().foregroundColor(Color.gray)
                                        }.frame(width: 4, height: 12)
                                    }
                                    .padding(.leading, 11.0)
                                }
                            }.padding(.leading)
                        }
                        Seperator()
                            .padding(.top)
                        Group {
                            Text("Address Info")
                                .font(.system(size: 20.0, weight: .semibold, design: .rounded))                                .padding(.vertical)
                            Text("Camryn Crowder")
                                .font(.system(size: 16.0, weight: .regular, design: .rounded))                                .padding(.bottom, 3.0)
                            Text("6995 Grenoble DR C")
                                .font(.system(size: 16.0, weight: .regular, design: .rounded))                                .padding(.bottom, 3.0)
                            Text("Centerville, OH 45459-6076")
                                .font(.system(size: 16.0, weight: .regular, design: .rounded))                                .padding(.bottom, 3.0)
                                .padding(.bottom)
                        }
                        .padding(.leading)
                        Seperator()
                        Group {
                            Text("Order Info")
                                .font(.system(size: 20.0, weight: .medium, design: .rounded))                                .padding(.bottom, 3.0)
                                .padding(.vertical)
                            Button(action: {
                            }) {
                                VStack(alignment: .leading) {
                                    Text("View or Change this order")
                                        .font(.system(size: 16.0, weight: .regular, design: .rounded))                                .padding(.bottom, 3.0)
                                        
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 45, alignment: .leading)
                                }.buttonStyle(PlainButtonStyle())
                            }
                            Divider()
                            Button(action: {
                            }) {
                                VStack(alignment: .leading) {
                                    Text("Cancel order")
                                        .font(.system(size: 16.0, weight: .regular, design: .rounded))                                .padding(.bottom, 3.0)
                                        
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 45, alignment: .leading)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.leading)
                    }
                }
            }
        }
        .navigationBarTitle("In Progress", displayMode: .inline)
    }
}
struct OrderProgressView_Previews: PreviewProvider {
    static var previews: some View {
        OrderProgressView()
    }
}


