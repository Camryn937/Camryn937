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
//  ThanksView.swift
//  Services
//
//  Created by Camryn Crowder on 11/5/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI

struct ThanksView: View {
    @State var isHidden = false
    var body: some View {
            VStack {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.green)
                Text("Thanks Camryn")
                    .font(.system(size: 24))

                Text("Use the Google Map app to remember & share your opinons about places you've visited.")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.all)
                    .frame(height: 100, alignment: .center)
                
                Button(action: {
                    withAnimation(.easeOut, {
                        isHidden = true
                    })
                }) {
                    Text("Done")
                        .foregroundColor(.blue)
                        .frame(width: 150, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color("Shadow"), radius: 6, x: 2, y: 2)
                }
                Divider()
            }
            .padding(.vertical)
            .frame(height: isHidden ? 0 : 350 )
            .isHidden(isHidden)
    }
}

struct ThanksView_Previews: PreviewProvider {
    static var previews: some View {
        ThanksView()
    }
}

extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    /// ```
    /// Text("Label")
    ///     .isHidden(true)
    /// ```
    ///
    /// Example for complete removal:
    /// ```
    /// Text("Label")
    ///     .isHidden(true, remove: true)
    /// ```
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
