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



struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var success: Bool?
    @ObservedObject var user: AuthUser
    
    init(user: AuthUser) {
        self.user = user
    }
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding(.all)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            SecureField("Password", text: $password).padding(.all).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            Button(action:
                    {
                        user.authLogin()
                    }
            ) {
                HStack {
                    Spacer()
                    Text("Login").foregroundColor(Color.white).padding(.all)
                    Spacer()
                }.background(Color.blue)
            }
            
        }
    }

    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(user: AuthUser())
    }
}

