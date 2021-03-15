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

struct AboutView: View {
    @State var loaded = false
    
    var body: some View {
            VStack(alignment: .leading) {
                    Text("Details")
                        .font(.headline)
                        .padding(.vertical)
                    Text("Huge place with classic American eats, candy-themed shakes & cocktails plus an on-site sweet shop.")
                        .font(.subheadline)
                        .foregroundColor(Color("Text"))
                    HStack {
                        VStack {
                            Image(systemName: "bolt")
                                .resizable()
                                .scaledToFit()
                            Text("Fast Service")
                                .font(.caption)
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "flame")
                                .resizable()
                                .scaledToFit()
                            Text("Fast Service")
                                .font(.caption)
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "scribble")
                                .resizable()
                                .scaledToFit()
                            Text("Fast Service")
                                .font(.caption)
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                            Text("Fast Service")
                                .font(.caption)
                        }
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center)
                    .padding(.vertical)
                    Text("Service options")
                        .font(.headline)
                        .fontWeight(.regular)
                        .padding(.vertical)
                    ForEach(0..<10) { i in
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark")
                            Text("Takeout")
                                .font(.callout)
                                .fontWeight(.light)
                            Spacer()
                            Image(systemName: "xmark")
                            Text("Dine-in")
                                .font(.callout)
                                .fontWeight(.light)
                            Spacer()
                        }
                        .padding(.bottom)
                    }
                    Divider()
                    Spacer()
                }
            .padding([.top, .leading, .trailing])
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
