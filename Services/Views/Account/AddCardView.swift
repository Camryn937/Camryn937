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
//  Created by: Camryn Crowder on 3/12/21
//  Copyright © 2021 Capsule. All rights reserved.
//

import SwiftUI


struct AddCardView: View {
    @Binding var input: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Card number")
                .font(.system(size: 14.0, weight: .regular, design: .rounded))
            TextField("Add Card", text: $input)

        }
    }
}


struct InputView: View {
    @Binding var input: String
    let lable: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(lable)
                .font(.system(size: 14.0, weight: .regular, design: .rounded))
            TextField(placeholder, text: $input)

        }
    }
}

struct AddCardView_Wrapper: View {
    @State var input = ""

    var body: some View {
        AddCardView(input: $input)
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView_Wrapper()
    }
}
