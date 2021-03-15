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
//  CapsuleGridView.swift
//  Services
//
//  Created by Camryn Crowder on 10/22/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI

struct CapsuleGridView: View {
    var body: some View {
        BarView(value: 100)
    }
}

struct CapsuleGridView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            HStack {
                CapsuleGridView()
                Spacer()
            }
            
        }
    }
}

struct BarView: View {
    var value: CGFloat
    
    var body: some View {
            HStack {
                ZStack(alignment: .bottom) {
                    Capsule().fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color("Capsule"))
                        .frame(width: 150, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    HStack {
                        Capsule().fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(Color(red: 0.978, green: 0.731, blue: 0.034))
                            .frame(width: value, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.frame(width: 150)
                }
                Spacer()
            }
    }
}

