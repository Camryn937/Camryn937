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
//  Created by: Camryn Crowder on 2/25/21
//  Copyright © 2021 Capsule. All rights reserved.
//

import SwiftUI

struct SearchInputView: View {
    @State var input = ""
    var body: some View {
        HStack {
            Image(systemName: "person").foregroundColor(.gray).padding(.leading, 8.0)
            TextField("Enter your firstName", text: $input)
                .padding(.vertical, 5.0)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 22.0, weight: .regular, design: .rounded))
                .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth: 5)
                            .frame(height: 32))
            Image(systemName:"exclamationmark.triangle.fill").foregroundColor(Color.red).padding(.trailing, 8.0)
        }
        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 1))
    }
}

struct SearchInputView_Previews: PreviewProvider {
    static var previews: some View {
        SearchInputView()
    }
}
