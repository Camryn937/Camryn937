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

//struct FullModal: View {
//    @ObservedObject var order: Order
//    @ObservedObject var user: AuthUser
//    var isPresented: Bool
//    var tabBar: Bool
//    var height: CGFloat
//    
//    var body: some View {
//        ZStack {
//            Group {
//                switch viewRouter.modalView {
//                
//                case 0: CartView(order: order, user: user)
//                    
//                case 1: UpdateUserView(firstname: "", lastname: "", emaildata: "", phone: "")
//                    
//                case 2: Text("Quote")
//                    
//                default: AddressView()
//                    
//                }
//            }
//            .offset(y: CGFloat(isPresented ? 0 : height ))
//        }.zIndex(1.0)
//    }
//}
