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
//  MessageView.swift
//  WhatsAppSwiftUI
//
//  Created by Dino on 09/09/2019.
//  Copyright © 2019 Dino Srdoc. All rights reserved.
//

 import SwiftUI
 
 
 struct MessageView: View {
     let message: Message
     
     private var activeBackgroundColor: Color {
         message.sender == .me ? Color("MessageBackgroundCurrentUser") : Color("MessageBackgroundOtherUser")
     }
     private var activeForegroundColor: Color {
         message.sender == .me ? Color("MessageForegroundCurrentUser") : Color("MessageForegroundOtherUser")
     }
     
     var body: some View {
         HStack {
             if message.sender == .me {
                 Spacer()
             }
             
             VStack(alignment: message.sender == .me ? .trailing : .leading, spacing: 0) {
                 Text(message.content)
                     .multilineTextAlignment(.leading)
                     .fixedSize(horizontal: false, vertical: true)
                     .padding(.horizontal, 12)
                     .padding(.vertical, 8)
                     .background(activeBackgroundColor)
                     .foregroundColor(activeForegroundColor)
                     .cornerRadius(12)
                     .offset(x: message.sender == .me ? -4 : 4, y: 0)
             }
             
             if message.sender != .me {
                 Spacer()
             }
         }
     }
 }

 struct MessageView_Previews: PreviewProvider {
     static var previews: some View {
         MessageView(message: Message.mock)
     }
 }
