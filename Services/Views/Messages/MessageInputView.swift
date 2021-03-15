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
//  MessageInputView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 11/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import SwiftUI

struct MessageInputView: View {
    @Binding var input: String
    let onCommit: (String) -> Void
    var body: some View {
        ZStack {
        GeometryReader { geo in
                HStack(spacing: 5.0) {
                    ContentTextView(text: $input, placeholderText: "Message...", width: geo.size.width - 90)
                    Button(action: {
                        if input != "" || input != " " {
                            self.onCommit(self.input)
                            self.input = ""
                        }
                    }) {
                        Text("Send")
                            .frame(width: 65, height: 40, alignment: .center)
                    }
                    .cornerRadius(8)
                }
                .frame(width: geo.size.width, alignment: .bottom)
            }
        }
        .background(Color.clear)
        .zIndex(2.0)
    }
}

//struct MessageInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageInputView(onCommit: { _ in })
//    }
//}


