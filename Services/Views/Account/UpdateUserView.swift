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
//  UpdateUserView.swift
//  Services
//
//  Created by Camryn Crowder on 11/3/20.
//  Copyright © 2020 Capsule. All rights reserved.
//

import SwiftUI

struct UpdateUserView: View {
    @State var fname = ""
    @State var lname = ""
    @State var number = ""
    @State var email = ""
    @State var loading = false
    @Binding var loaded: Bool
    @State var changed = false
    let emaildata: String?
    let phone: String?
    
    @State var changePassword = false
    var user: UserAccount?
    @Binding var isShown: Bool
    @State var error = false
    
    var body: some View {
        GeometryReader { geo in
                VStack(spacing: 15.0) {
                    if error {
                        Text("Error")
                            .fontWeight(.bold)
                            .padding(.vertical, 2.0)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.red)
                    }

                    Group {
                        
                        UpdateField(title: "First Name", data: user?.firstName, width:  geo.size.width/3, placeholder: user?.firstName ?? "John", input: $fname.onChange(toggled))
                        
                        UpdateField(title: "Last Name", data: user?.lastName, width:  geo.size.width/3, placeholder: user?.lastName ?? "Appleseed", input: $lname.onChange(toggled))
                        
                        Divider()
                        
                        UpdateField(title: "Phone Number", data: user?.profile?.phone, width:  geo.size.width/3, placeholder: user?.profile?.phone ?? "(999)-999-9999", input: $number.onChange(toggled))
                        
                        UpdateField(title: "Email", data: user?.email, width:  geo.size.width/3, placeholder: user?.email ?? "john.smith@gmail.com", input: $email.onChange(toggled))
                    }
                    .padding(.horizontal)
                    
                    Seperator()
                    Button(action: {
                        changePassword.toggle()
                    }) {
                        AccountNavLinkItem(title: "Change your password")
                            .padding([.leading, .bottom])
                    }
                    
                    Button(action: {
                        if changed {
                            loading.toggle()
                        }
                        else {
                            isShown.toggle()
                        }
                    }) {
                        VStack {
                            HStack {
                                if loading {
                                    AnimationCircleStrokeSpin(size: 20)
                                }
                                else {
                                    
                                    if !changed {
                                        Text("Cencel")
                                            .font(.system(size: 18.0, weight: .medium, design: .rounded))
                                            .fontWeight(.bold)
                                    }
                                    
                                    else {
                                        Text("Save")
                                            .font(.system(size: 18.0, weight: .medium, design: .rounded))
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                            .frame(width: geo.size.width/2, height: 40, alignment: .center)
                            .background(changed ? Color.green : Color.gray.opacity(0.45))
                            .cornerRadius(5)
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10.0)
                            
                            if error {
                                Text("Error Occurred")
                                    .foregroundColor(Color.red)
                            }
                        }
                    }
                    
                }
                .padding(.top, 15.0)
                .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
                .background(Color("Primary"))
                .overlay(
                    ChangePass(close: $changePassword)
                        .offset(x: changePassword ? 0 : 500, y: 0)
                        .animation(.easeIn(duration: 0.45))
                )}
        .background(Color("Primary"))
    }
}


extension UpdateUserView {
    func toggled(to value: String) {
        if fname.count > 0 || lname.count > 0 || number.count > 0 || email.count > 0 {
            changed = true
        }
        else {
            changed = false
        }
        
        print("Name changed!")
    }
}

struct UpdateUserView_Wrapper: View {
    @State var isShown = true
    @State var isShown3 = false

    var body: some View {
        UpdateUserView(loaded: $isShown, emaildata: nil, phone: nil, isShown: $isShown3)
    }
}

struct UpdateUserView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserView_Wrapper()
    }
}


struct UpdateField: View {
    let title: String
    let data: String?
    let width: CGFloat
    let placeholder: String
    @Binding var input: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18.0, weight: .bold, design: .rounded))
                .frame(width: width, alignment: .leading)
            TextField("\(data ?? placeholder)", text: $input)
        }
    }
}

