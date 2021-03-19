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
import PartialSheet

//MARK:- ServiceListView
//Home view
struct ServiceListView: View {
    @ObservedObject var order = Order()
    @State var services = [Service]()
    @State var loaded = false
    
    var body: some View {
        if !loaded {
            ServiceListLoadingView()
                .onAppear(perform: {
                    loadData()
                })
        }
        else {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        VStack() {
                            
                            ServicePromoView()
                            FeaturedServiceView(order: order, services: services)
                            Seperator()
                            AllServiceListView(order: order, services: services)
                        }
                    }
                }
                .navigationBarTitle("Services", displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                                            print("User icon pressed...")
                                        }) {
                                            NavigationLink(destination: MessageList()) {
                                                Image(systemName: "paperplane").imageScale(.large)
                                                    .foregroundColor(Color.black)
                                            }
                                        })
                .navigationViewStyle(StackNavigationViewStyle())
            }
//            .background(Color("Primary"))
//            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
struct ServiceListView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceListView(order: Order(), services: [], loaded: false)
    }
}

//MARK:- REQUEST
extension ServiceListView {
    func loadData() {
        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/", for: [Service].self, using: .get) { data in
            switch data {
                case .success(let data):
                    services = data
                    loaded = true
                    
                default:
                    print("failure xx")
            }
        }
    }
}

//Supporting Services View
struct AllServiceListView: View {
    @ObservedObject var order: Order
    @State var services: [Service]
    
    var body: some View {
        VStack(alignment: .leading) {
                Text("All Services")
                    .font(.system(size: 22.0, weight: .medium, design: .rounded))

            ForEach(services, id: \.self) { service in
                //Navigate to the nearest location in the index
                NavigationLink(destination: ServiceView(id: service.location?[0].id ?? 0)) {
                    VStack {
                        Group {
                            Image("placeholder-image")
                                .resizable()
                                .background(Color.blue)
                                .cornerRadius(6)
                        }
                        
                        HStack {
                            VStack {
                                Text(service.name)
                                    .font(.system(size: 20.0, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color("Text"))
                                Text("")
                                    .font(.system(size: 14.0, weight: .medium, design: .rounded))
                                    .foregroundColor(Color("Default-Text"))
                            }
                            
                            Spacer()
                            
                            Text("5")
                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                .padding(.bottom, 7.0)

                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 18, height: 18, alignment: .center)
                                .foregroundColor(Color("Star"))
                                .padding(.bottom, 7.0)
                        }
                    }
                    .frame(height: 220)
                }
                .buttonStyle(PlainButtonStyle())
                
                Divider()
            }
        }
        .padding(.horizontal)
    }
}

