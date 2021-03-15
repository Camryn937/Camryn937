///// Copyright (c) 2020 Capsule LLC
/////
///// Permission is hereby granted, free of charge, to any person obtaining a copy
///// of this software and associated documentation files (the "Software"), to deal
///// in the Software without restriction, including without limitation the rights
///// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
///// copies of the Software, and to permit persons to whom the Software is
///// furnished to do so, subject to the following conditions:
/////
///// The above copyright notice and this permission notice shall be included in
///// all copies or substantial portions of the Software.
/////
///// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
///// distribute, sublicense, create a derivative work, and/or sell copies of the
///// Software in any work that is designed, intended, or marketed for pedagogical or
///// instructional purposes related to programming, coding, application development,
///// or information technology.  Permission for such use, copying, modification,
///// merger, publication, distribution, sublicensing, creation of derivative works,
///// or sale is expressly withheld.
/////
///// This project and source code may use libraries or frameworks that are
///// released under various Open-Source licenses. Use of those libraries and
///// frameworks are governed by their own individual licenses.
/////
////
////  TabView.swift
////  Services
////
////  Created by Camryn Crowder on 10/22/20.
////  Copyright © 2020 Capsule. All rights reserved.
////
//
//import SwiftUI
//
//struct TabView: View {
//    var tabBarShown: Bool
//    var checkoutButton: Bool
//    var checkoutShown: Bool
//    var icons = ["person.circle", "magnifyingglass", "square.grid.2x2", "bubble.left", "list.bullet"]
//    
//    var body: some View {
//        GeometryReader { geometry in
//            VStack {
//                Spacer()
//                ZStack {
//                    
//                    Button(action: {
//                    }) {
//                        Text("Continue")
//                            .fontWeight(.bold)
//                            .foregroundColor(Color.white)
//                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45, maxHeight: 50, alignment: .center)
//                            .background(Color.blue)
//                            .shadow(color: Color("Shadow"),radius: 3, x: 3, y: 3)
//                            .cornerRadius(8.0)
//                    }
//                    .padding([.leading, .bottom, .trailing])
//                    .shadow(color: Color("Shadow"), radius: 3, x: 0.0, y: 4.0)
//                    .offset(x: 0, y: checkoutButton ? -80 : 0)
//                    Rectangle()
//                        .shadow(color: Color("Shadow"), radius: 3, x: 0.0, y: 0.0)
//                        .frame(width: geometry.size.width, height: 90, alignment: .top)
//                        .background(Color("Secondary"))
//                    
//                        HStack(alignment: .top, spacing: 0.0) {
//                            ForEach(0..<icons.count) { icon in
//                                TabButton(image: icons[icon])
//                                    .padding(.top)
//                                    .frame(width: geometry.size.width/5, height: 90, alignment: .top)
//                                    .background(Color("Secondary"))
////                                    .foregroundColor(viewRouter.currentView == icon ? Color.blue  : Color(red: 0.444, green: 0.439, blue: 0.443))
//                            }
//                        }
//                }
//                .offset(x:0, y: tabBarShown ? 0 : geometry.size.height)
//            }
//        }
//    }
//}
//
//
//struct TabviewWrapper: View {
//    var tab = true
//    var cart = true
//    var body: some View {
//        TabView(tabBarShown: tab, checkoutButton: cart, checkoutShown: cart)
//    }
//}
//
//struct TabView_Previews: PreviewProvider {
//    
//    
//    static var previews: some View {
//        TabviewWrapper()
//            .previewLayout(.sizeThatFits)
//    }
//}
//
////.background(Color.white)
////.shadow(color: Color(hue: 1.0, saturation: 0.052, brightness: 0.765, opacity: 0.599), radius: 5, x: 0.0, y: 0.0)
////.offset(x:0, y: tabBarShown ? 0 : UIApplication.shared.keyWindow?.frame.height ?? 0)
//
//
////Group {
////    Button(action: {
////        withAnimation{
////            viewRouter.navbarIsHidden = true
////            viewRouter.currentView = 4
////        }
////        order.update()
////    }) {
////        Text("Continue \((order.total * 0.85)/10 + 200/100, specifier: "%.2f")")
////            .fontWeight(.bold)
////            .foregroundColor(Color.white)
////            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45, maxHeight: 50, alignment: .center)
////    }
////    .background(Color.blue)
////    .shadow(color: Color.black.opacity(0.3),radius: 3, x: 3, y: 3)
////
////}.cornerRadius(8.0)
////.padding([.leading, .bottom, .trailing])
////.shadow(color: Color(hue: 1.0, saturation: 0.042, brightness: 0.5, opacity: 0.648), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
