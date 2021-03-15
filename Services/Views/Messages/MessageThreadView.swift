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
//  MessageThreadView.swift
//  Services
//
//  Created by Camryn Crowder on 11/7/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI

struct MessageThreadView: View {
    @State var messages: [Message] = {
        let decoder = JSONDecoder()
        let data = allMessagesString.data(using: .utf8)!
        return try! decoder.decode([Message].self, from: data)
    }()
    @State private var input = ""

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                MessageListView(messages: messages)
                    
                MessageInputView(input: $input) { enteredText in
                            let id = (self.messages.map { $0.id }.max() ?? 0) + 1
                            let message = Message(id: id, sender: .me, content: enteredText)
                            self.messages.append(message)
                    }
                .frame(height: 80, alignment: .bottom)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color("Primary"))
    }
}


struct MessageThreadView_preview: PreviewProvider {
    static var previews: some View {
        MessageThreadView()
    }
}

let allMessagesString = """
[
    {
        "id": 0,
        "content": "Hi there John!",
        "sender": "me"
    },
    {
        "id": 1,
        "content": "Hello.",
        "sender": "John"
    },
    {
        "id": 2,
        "content": "What's for dinner tomorrow? I've been thinking about making some triple layered apple pie with the Golden Smiths that Jonathan has given us.",
        "sender": "me"
    },
    {
        "id": 3,
        "content": "How about some fried apples?",
        "sender": "John"
    },
    {
        "id": 3,
        "content": "How about some fried apples?",
        "sender": "John"
    },
    {
        "id": 3,
        "content": "How about some fried apples?",
        "sender": "John"
    },
    {
        "id": 0,
        "content": "Hi there John!",
        "sender": "me"
    },
    {
        "id": 1,
        "content": "Hello.",
        "sender": "John"
    },
    {
        "id": 2,
        "content": "What's for dinner tomorrow? I've been thinking about making some triple layered apple pie with the Golden Smiths that Jonathan has given us.",
        "sender": "me"
    },
    {
        "id": 3,
        "content": "How about some fried apples?",
        "sender": "John"
    },
    {
        "id": 3,
        "content": "How about some fried apples?",
        "sender": "John"
    },
    {
        "id": 3,
        "content": "How about some fried apples?",
        "sender": "John"
    },
    {
        "id": 0,
        "content": "Hi there John!",
        "sender": "me"
    },
    {
        "id": 1,
        "content": "Hello.",
        "sender": "John"
    },
    {
        "id": 2,
        "content": "What's for dinner tomorrow? I've been thinking about making some triple layered apple pie with the Golden Smiths that Jonathan has given us.",
        "sender": "me"
    },
    {
        "id": 3,
        "content": "How about some fried apples?",
        "sender": "John"
    },
    {
        "id": 3,
        "content": "How about some fried apples?",
        "sender": "John"
    },
    {
        "id": 3,
        "content": "How about some fried apples?",
        "sender": "John"
    }
]

"""
