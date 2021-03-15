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

struct SearchView: View {
    var body: some View {
        VStack {
            SearchInputView()
                .padding([.leading, .bottom, .trailing], 4.0)
            
            ScrollView {
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "person")
                                .frame(width: UIScreen.main.bounds.width/4-10, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Image(systemName: "person")
                                .frame(width: UIScreen.main.bounds.width/4-10, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Image(systemName: "person")
                                .frame(width: UIScreen.main.bounds.width/4-10, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Image(systemName: "person")
                                .frame(width: UIScreen.main.bounds.width/4-10, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        HStack {
                            Image(systemName: "person")
                                .frame(width: UIScreen.main.bounds.width/4-10, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Image(systemName: "person")
                                .frame(width: UIScreen.main.bounds.width/4-10, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Image(systemName: "person")
                                .frame(width: UIScreen.main.bounds.width/4-10, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Image(systemName: "person")
                                .frame(width: UIScreen.main.bounds.width/4-10, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width-6, height: 210, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Divider()
                    
                    HStack {
                        Text("Hello")
                            .font(.system(size: 16.0, weight: .regular, design: .rounded))
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .background(Color.white)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 230)
                    .background(Color.gray)
                    
                    VStack(alignment: .leading) {
                        Text("Promo Services")
                            .font(.system(size: 28.0, weight: .bold, design: .rounded))

                        HStack(alignment: .center) {
                            Text("Classic Choices")
                                .font(.system(size: 22.0, weight: .semibold, design: .rounded))
                            Spacer()
                            Text("...")
                                .font(.system(size: 28.0, weight: .bold, design: .rounded))
                        }

                        Text("Get it fast")
                            .font(.system(size: 22.0, weight: .semibold, design: .rounded))

                    }
                    .padding(.vertical)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
