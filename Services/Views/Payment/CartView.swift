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

struct CartView: View {
    @ObservedObject var order: Order
    @State var isSubscription = false
    @State var isDelivery = false
    @State var isSelected = false
    @State var cart: Cart?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NavigationView {
                    ZStack(alignment: .center) {
                        
                        VStack(alignment: .leading) {
                            List {
                                //Control flow to not display section if it doesnt apple i.e isnt sub scribable or deliverable
                                OrderOptionView(willsubscribe: $isSubscription, delivery: $isDelivery, isDeliverable: true, isSubscribable: true)
                                
                                ServiceSection(itemsInCart: cart?.items_in_cart ?? [], isSelected: $isSelected, order: order)
                                
                                CartTotalView()
                            }
                            .navigationBarTitle("Cart", displayMode: .inline)
                            .listStyle(GroupedListStyle())
                        }
                        
                        //Continue button
                        VStack {
                            Spacer()
                            NavigationLink(destination: CheckoutView(isDelievery: isDelivery)) {
                                Text("Continue")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45, maxHeight: 50, alignment: .center)
                                    .background(Color.green)
                                    .cornerRadius(8.0)
                                    .shadow(color: Color.black.opacity(0.3),radius: 5, x: 3, y: 3)
                                    .padding([.leading, .trailing])
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: { loadData() })
    }
    func delete(at offsets: IndexSet) {
        //        order.cart.remove(atOffsets: offsets)
    }
    func loadData() {
        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/service/my/cart/", for: Cart.self, using: .get) { data in
            switch data {
                case .success(let data):
                    cart = data
                    
                default:
                    print("failure xx")
            }
        }
    }
}


#if DEBUG
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(order: Order())
    }
}
#endif

struct CartContainer: View {
    @Binding var isPresented: Bool
    @ObservedObject var order: Order
    
    var body: some View {
        Button(action: {
            self.isPresented = true
        }) {
            CartView(order: order)
        }
        .padding()
        .background(Color.blue)
        .actionSheet(isPresented: $isPresented, content: {
            ActionSheet(title: Text("iOSDevCenters"), message: Text("SubTitle"), buttons: [
                .default(Text("Save"), action: {
                    print("Save")
                }),
                .default(Text("Delete"), action: {
                    print("Delete")
                }),
                .destructive(Text("Cancel"))
            ])
        })
    }
}

//ZStack {
//    Rectangle()
//        .frame(height: geometry.size.height)
//        .opacity(0.3)
//}.edgesIgnoringSafeArea(.all)

//NavigationLink(destination: CheckoutView()) {
//        Text("Continue")
//            .fontWeight(.bold)
//            .foregroundColor(Color.white)
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45, maxHeight: 50, alignment: .center)
//            .background(Color.green)
//            .cornerRadius(8.0)
//    .shadow(color: Color.black.opacity(0.3),radius: 5, x: 3, y: 3)
//    .padding([.leading, .bottom, .trailing])
//}.zIndex(6.0)

//ZStack {
//    Rectangle()
//        .opacity(0.3)
//}
//.zIndex(5.0)
//.edgesIgnoringSafeArea(.all)

