///// Copyright (c) 2020 Capsule LLC
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
//  Services
//
//  Created by: Camryn Crowder on 1/10/21
//  Copyright © 2021 Capsule. All rights reserved.
//

import SwiftUI

struct ServiceListLoadingView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(height: 140)
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 200, height: 24, alignment: .leading)
                    HStack {
                        VStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 300, height: 200)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 150, height: 16)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 300, height: 20)
                        }
                        VStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 300, height: 200)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 300, height: 16)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 300, height: 20)
                        }
                    }
                    .padding(.bottom)
                }
                .padding(.leading)
            }
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 150, height: 24)
                .padding(.leading)

            RoundedRectangle(cornerRadius: 5)
                .padding(.horizontal)
                .frame(maxHeight: 200)
        }
        .disabled(true)
        .foregroundColor(.gray)
        .opacity(0.4)
    }
}

struct ServiceListLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceListLoadingView()
    }
}
