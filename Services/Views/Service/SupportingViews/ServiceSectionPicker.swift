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
//  ServiceSectionPicker.swift
//  Services
//
//  Created by Camryn Crowder on 12/27/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI

struct ServiceSectionPicker: View {
    //    var hasGallery: Bool
    @Binding var selected: Int
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
            VStack {
                HStack {
                    ScrollHeaderButton(label: "Service", identifier: 0, selected: self.$selected)
                        .onTapGesture {
                            selected = 0
                            impactMed.impactOccurred()
                        }
                    ScrollHeaderButton(label: "Reviews", identifier: 1, selected: self.$selected)
                        .onTapGesture {
                            selected = 1
                            impactMed.impactOccurred()
                        }
                    ScrollHeaderButton(label: "Photos", identifier: 2, selected: self.$selected)
                        .onTapGesture {
                            selected = 2
                            impactMed.impactOccurred()
                        }
                    ScrollHeaderButton(label: "About", identifier: 3, selected: self.$selected)
                        .onTapGesture {
                            selected = 3
                            impactMed.impactOccurred()
                        }
                }
                .frame(height:40)
                Divider()
            }
            .background(Color("Primary"))
    }
}

struct ServiceSectionPicker_Wrapper: View {
    @State var sel = 0
    var body: some View {
        ServiceSectionPicker(selected: $sel)
    }
}

struct ServiceSectionPicker_Previews: PreviewProvider {
    static var previews: some View {
        ServiceSectionPicker_Wrapper()
    }
}

struct ScrollHeaderButton: View {
    var label = ""
    var identifier = 0
    @Binding var selected: Int
    
    var body: some View {
        Group {
            Text(label)
                .font(.system(size: 16.0, weight: .regular, design: .rounded))
                .foregroundColor(self.selected == self.identifier ? Color.black : Color("Text"))
                .fontWeight(self.selected == self.identifier ? .bold : .regular)
                .fontWeight(.medium)
                .padding(.horizontal)
                .padding(.vertical, 2.0)
                .background(self.selected == self.identifier ? Color(red: 0.978, green: 0.731, blue: 0.034) : Color("Primary"))
                .cornerRadius(6)
        }
    }
}
