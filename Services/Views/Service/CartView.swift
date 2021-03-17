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
    @State var subscription = true
    @State var delivery = true
    @State var isPresented = false
    @State var checkout = [Cart]()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NavigationView {
                    ZStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            List {
                                
                                Section(
                                    header: Text("Order Options")
                                        .font(.system(size: 14.0, weight: .regular, design: .rounded)),
                                    footer: Text("Subscriptions are billed monthly from initial purchase")
                                        .font(.system(size: 14.0, weight: .regular, design: .rounded))) {
                                        
                                        //Frequenct Picker
                                        HStack {
                                            Picker(selection: $subscription, label: Text("Picker")) {
                                                Text("One Time").tag(true)
                                                Text("Recurring").tag(false)
                                            }.pickerStyle(SegmentedPickerStyle())
                                        }
                                    
                                    if !subscription {
                                        withAnimation {
                                            Picker(selection: $delivery, label: Text("Frequency")) {
                                                Text("Drop Off").tag(false)
                                                Text("Delivery").tag(true)
                                            }
                                        }
                                    }
                                    
                                    Picker(selection: $delivery, label: Text("Delivery Choice")) {
                                        Text("Drop Off").tag(false)
                                        Text("Delivery").tag(true)
                                    }
                                }
                                
                                Section(header: Text("Items")
                                .font(.system(size: 14.0, weight: .medium, design: .rounded))) {
//                                    ForEach(checkout, id:\.self) { item in
//                                        Button(action: {
//                                            isPresented = true
//                                            if isPresented {
//                                                order.selectedItems = item.choice
//                                            }
//                                            else {
//                                                order.selectedItems = [OptionsList.Options]()
//                                            }
//                                        } ) {
//                                            VStack(alignment: .leading) {
//                                                HStack {
//                                                    VStack(alignment: .leading) {
//                                                        Text(item.serviceItem.name)
//                                                        .font(.system(size: 18.0, weight: .medium, design: .rounded))
//                                                        HStack {
//                                                            ForEach(item.choice, id:\.self) { choice in
//                                                                Text("\(choice.name)")
//                                                                    .font(.system(size: 14.0, weight: .light, design: .rounded))
//                                                            }
//                                                        }
//                                                    }
//                                                    Spacer()
//                                                    Text("$2.00")
//                                                        .font(.system(size: 16.0, weight: .medium, design: .rounded))
//                                                }
//                                                .padding(.trailing)
//                                                .sheet(isPresented: self.$isPresented, onDismiss: order.cancel) {
//                                                    ServiceItemView(edit: true, optionList: [], itemHeader: item.serviceItem, order: order, isShown: self.$isPresented, locationId: 18)
//                                                }
//                                            }
//                                            .background(Color("Main-Background"))
//                                        }
//                                        .buttonStyle(PlainButtonStyle())
//                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Total")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                    }
                                    .padding(.vertical)
                                    HStack {
                                        Text("Subtotal")
                                        Spacer()
                                        Text("0.00")
                                    }
                                    .padding(.bottom, 3.0)
                                    HStack {
                                        Text("Fees and Estimated tax")
                                        Spacer()
                                        Text("0.00")
                                    }
                                    .padding(.bottom, 3.0)
                                    HStack {
                                        Text("Delivery")
                                            .fontWeight(.regular)
                                        
                                        Spacer()
                                        Text("0.00")
                                    }
                                    .padding(.bottom)
                                }
                                
                            }
                            .navigationBarTitle("Cart", displayMode: .inline)
                            .listStyle(GroupedListStyle())
                        }
                        
                        VStack {
                            Spacer()
                            NavigationLink(destination: CheckoutView()) {
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
                        .padding(.vertical)
                    }
                }
            }
            .padding(.top)
        }
        .onAppear(perform: { loadData() })
    }
    func delete(at offsets: IndexSet) {
//        order.cart.remove(atOffsets: offsets)
    }
    func loadData() {
        let request = AF.request("http://192.168.1.75:8000/service/my/cart/")
        request.responseDecodable(of: Cart.self) { (response) in
            guard let data = response.value else { return }
            checkout = [data]
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
