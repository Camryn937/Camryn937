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

struct CheckoutView: View {
//    @State private var enableLogging = false
    let isDelievery: Bool
    
    @State var address = ["6995 Grenoble drv", "9650 Summit Point drv", "47 Leroy St"]
    @State var phone = ["123456789", "123456782", "234567893", "2345678904"]
    @State var options = ["Hand it to me", "Leave it at my door"]
    
    @State private var selectedAddressIndex = 0
    @State private var selectedPhoneIndex = 0
    @State private var selectedOptionsIndex = 0

    @State private var selectedTime = 0
    @State var isScheduled = true

    var body: some View {
        VStack {
                ZStack {
                    List {
                        Section(header: Text("Delivery details")) {
                            Picker(selection: $selectedAddressIndex, label: Text("Address")) {
                                ForEach(0..<address.count) {
                                    Text("\(address[$0])")
                                }
                            }

                            Picker(selection: $selectedPhoneIndex, label: Text("Phone")) {
                                ForEach(0..<phone.count) {
                                    Text("\(phone[$0])")
                                }
                            }
                            
                            Picker(selection: $selectedOptionsIndex, label: Text("Options")) {
                                ForEach(0..<options.count) {
                                    Text("\(options[$0])")
                                }
                            }
                        }
                        
                        Section(header: Text("Delivery Schedule")) {
                            VStack {
                                Picker(selection: $isScheduled, label: Text("")) {
                                    Text("ASAP").tag(false)
                                    Text("Scheduled").tag(true)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                
                                if isScheduled {
                                    withAnimation {
                                        DatePicker(selection: .constant(Date()), label: { Text("Date") })
                                    }
                                }
                            }
                        }
                        
                        Section(header: Text("Select Payment Option")) {
                            NavigationLink(destination: Text("address")) {
                                Text("Payment")
                                    .lineLimit(1)
                                Spacer()
                                Text("Apple Pay")
                                    .lineLimit(1)
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle("Checkout")
                    VStack {
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                            Text("Place Order")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45, maxHeight: 50, alignment: .center)
                                .background(Color.green)
                                .cornerRadius(8.0)
                        }
                        .shadow(color: Color.black.opacity(0.3),radius: 5, x: 3, y: 3)
                        .padding(.all)
                    }
                    .padding(.top)
                }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(isDelievery: true)
    }
}


//Section {
//    Picker(selection: $selectedStrength, label: Text("Payment")) {
//        ForEach(0 ..< address.count) {
//            Text(self.address[$0])
//        }
//    }
//}


//Section(header: Text("Order Details")) {
//    Picker(selection: $selectedTime, label: Text("Select a color")) {
//        ForEach(0 ..< times.count) {
//            Text(self.times[$0]).tag($0)
//        }
//    }.pickerStyle(SegmentedPickerStyle())
//}
