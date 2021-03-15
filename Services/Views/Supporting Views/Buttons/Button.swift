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
//  Button.swift
//  Services
//
//  Created by Camryn Crowder on 11/3/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI


struct BackArrowButton: View {
    let callback: () -> ()
    
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Image(systemName: "arrow.left.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(Color(hue: 1.0, saturation: 0.009, brightness: 0.253))
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    .foregroundColor(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.755), radius: 5, x: 0, y: 1)
                Spacer()
            }
            .padding(.all)
            .background(Color.clear)
        }
        .onTapGesture { callback() }
        .zIndex(2.0)
    }
}

struct MenuIssueButton: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {print("Report!!")}) {
                Text("Report menu issue")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
            }.padding(.vertical)
            Spacer()
        }
    }
}

struct TabButton: View {
    var image: String
    
    var body: some View {
        VStack(spacing: 10.0) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
        }
        .frame( width: 20 ,height: 20)
        .padding([.bottom])
    }
}

