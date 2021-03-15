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

struct ReviewSkeleton: View {
    var body: some View {
        VStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 160, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .frame(width: 300)
                .offset(y: -40)
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 160, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .frame(width: 180)
                Spacer()
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 160, alignment: .trailing)
                    .frame(width: 140)
            }
            .offset(y: -20)
            Group {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 120, height: 16, alignment: .bottom)
            }
            .offset(y: -10)
            Group {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 250, height: 16, alignment: .bottom)
            }
            .offset(y: -10)
            Group {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 350, height: 80, alignment: .bottom)
            }
            
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 350, height: 20, alignment: .bottom)
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 300, height: 20, alignment: .bottom)
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 300, height: 20, alignment: .bottom)
            }
            .offset(y: 25)
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal)
    }
}

struct ReviewSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        ReviewSkeleton()
    }
}
