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

import Alamofire
import SwiftUI

struct SubscriptionPicker: View {
    @State var cart = [CartItem]()
    
    var body: some View {
        VStack {
            Text("Select Subscription items")
                .font(.headline)
                .fontWeight(.bold)
//            ForEach(cart, id: \.self) { item in
//                Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
//                    Text(item.serviceItem.name)
//                        .padding(.vertical)
//                        .frame(width: 300)
//                        .background(Color.white)
//                        .cornerRadius(8)
//                }
//                .padding(.horizontal)
//                .zIndex(10)
//                .shadow(color: Color.black.opacity(0.3),radius: 5, x: 3, y: 3)
//            }
        }.onAppear(perform: loadData)
    }
    func loadData() {
        let request = AF.request("http://172.16.0.3:8000/service/cart/")
        request.responseDecodable(of: Cart.self) { (response) in
            guard let data = response.value else { return }
			cart = data.items_in_cart
        }
    }
}

struct SubscriptionPicker_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionPicker()
    }
}
