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
//  MessageListView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 05/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

import Foundation
import SwiftUI

struct MessageListView: View {
    let messages: [Message]
    @State var proxy: ScrollViewProxy? = nil

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) { proxy in
                ForEach(self.messages) { message in
                    MessageView(message: message)
                        .padding(.all, 8)
                        .padding(self.paddingInsets(for: message, geometry: geometry))
                        .scrollId(messages.last)
                }
                .onAppear {
                    self.proxy = proxy
                    self.proxy?.scrollTo(messages.last, alignment: .bottom)
                }
            }
        }
    }
    
//    private func shouldDrawTail(for message: Message) -> Bool {
//        let currentMessageIndex = self.messages.firstIndex(of: message)
//        let nextMessageIndex = currentMessageIndex.flatMap { self.messages.index($0, offsetBy: 1, limitedBy: self.messages.count - 1) }
//        let isNextSenderSameAsCurrent = nextMessageIndex.map { self.messages[$0] }?.sender == message.sender
//
//        return !isNextSenderSameAsCurrent
//    }
    
    private func paddingInsets(for message: Message, geometry: GeometryProxy) -> EdgeInsets {
        let top: CGFloat
        let bottom: CGFloat
        
        let currentMessageIndex = self.messages.firstIndex(of: message)
        let nextMessageIndex = currentMessageIndex.flatMap { self.messages.index($0, offsetBy: 1, limitedBy: self.messages.count - 1) }
        let previousMessageIndex = currentMessageIndex.flatMap { self.messages.index($0, offsetBy: -1, limitedBy: 0) }
        let isPreviousSenderSameAsCurrent = previousMessageIndex.map { self.messages[$0] }?.sender == message.sender
        let isNextSenderSameAsCurrent = nextMessageIndex.map { self.messages[$0] }?.sender == message.sender
        
        if isPreviousSenderSameAsCurrent {
            top = -3
        } else {
            top = 0
        }
        
        if isNextSenderSameAsCurrent {
            bottom = -3
        } else {
            bottom = 0
        }
        
        return EdgeInsets(top: top, leading: 0, bottom: bottom, trailing: 0)

    }

}
