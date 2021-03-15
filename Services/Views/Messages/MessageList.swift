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

import SwiftUI
import Alamofire

struct MessageList: View {    
    var body: some View {
            ScrollView {
                VStack(spacing: 0.0) {
                    ForEach(0..<10) { i in
                        NavigationLink(destination: MessageThreadView()) {
                            HStack(alignment: .center, spacing: 0.0) {
                                Image(systemName: "circle.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:8, height: 8)
                                Image("placeholder-image")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .background(Color.black)
                                    .clipShape(Circle())
                                    .frame(width:70, height: 70)
                                VStack(alignment: .leading, spacing: 0.0) {
                                    Text("hello")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Text("hello")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .lineLimit(nil)
                                }
                                Spacer()
                                Text("9H")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                            }
                            .frame(height: 90, alignment: .center)
                            .padding(.horizontal)
                        }
                        Divider()
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .background(Color("Primary"))
            .foregroundColor(Color("Text"))
            .navigationBarTitle("Messages", displayMode: .inline)
    }
}

struct MessageList_Previews: PreviewProvider {
    static var previews: some View {
        MessageList()
    }
}
