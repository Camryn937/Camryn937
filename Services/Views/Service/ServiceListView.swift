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
    @ObservedObject var user = AuthUser()
    @State var services: ServiceList?
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
                    VStack {
                        ServicePromoView()
                        FeaturedServiceView(order: order, user: user, services: services!.services)
                        Seperator()
                        AllServiceListView(order: order, user: user, services: services!.services)
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
            .background(Color("Primary"))
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
struct ServiceListView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceListView()
    }
}

struct UIServiceListView: UIViewControllerRepresentable {
    @ObservedObject var order = Order()
    @ObservedObject var user = AuthUser()
    @State var services: ServiceList
    
    func makeUIViewController(context: Context) -> ServiceViewController {
        let vc = ServiceViewController()
        if services.services.count == 0 { vc.hc.rootView = AnyView(LoadingView(size: 80)) }
        else { vc.hc.rootView = AnyView(ServiceListView(order: order, user: user, services: services)) }
        return vc
    }
    func updateUIViewController(_ vc: ServiceViewController, context: Context) {
        vc.hc.rootView = AnyView(ServiceListView(order: order, user: user, services: services))
    }
}

//MARK:- REQUEST
extension ServiceListView {
    func loadData() {
        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/", for: ServiceList.self, using: .get) { data in
            switch data {
            case .success(let data):
                services = data
                loaded = true
                return loaded
                
            default:
                print("failure xx")
                return false
            }
        }
    }
}

//Supporting Services View
struct AllServiceListView: View {
    @ObservedObject var order: Order
    @ObservedObject var user: AuthUser
    @State var services: [Service]
    
    var body: some View {
        VStack(spacing: 0.0) {
            Group {
                Text("All Services")
                    .font(.system(size: 22.0, weight: .medium, design: .rounded))
            }
            .padding([.top, .leading, .trailing])
            .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(services, id: \.self) { service in
                //Navigate to the nearest location in the index
                NavigationLink(destination: ServiceView(id: service.location?[0].id ?? 0)) {
                    VStack {
                        Group {
                            Image("placeholder-image")
                                .resizable()
                                .padding(.horizontal)
                                .background(Color.blue)
                                .cornerRadius(6)
                        }
                        .padding(.horizontal)
                        HStack(spacing: 2.0) {
                            VStack(alignment: .leading) {
                                //                                            Text("Opens Sun at 10:00 AM")
                                //                                                .font(.system(size: 18.0, weight: .semibold, design: .rounded))
                                //                                                .foregroundColor(.blue)
                                Text(service.name)
                                    .font(.system(size: 20.0, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color("Text"))
                                Text("")
                                    .font(.system(size: 14.0, weight: .medium, design: .rounded))
                                    .foregroundColor(Color("Default-Text"))
                                    .padding(.bottom, 7.0)
                            }
                            Spacer()
                            Text("5")
                                .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                .padding([.top, .trailing], 1.0)
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 16, height: 16, alignment: .center)
                                .foregroundColor(Color("Star"))
                        }
                        .padding([.leading, .trailing])
                    }
                    .padding(.vertical)
                    .frame(height: 280)
                    .overlay(
                        Rectangle()
                            .foregroundColor(.white)
                            .opacity(0.0)
                    )
                    Divider()
                }
                .buttonStyle(PlainButtonStyle())
                
                Divider()
            }
        }
    }
}

