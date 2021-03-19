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
import UIKit
import PartialSheet


struct AccountView: View {
    @State private var allowPushNotify = false
    @State private var allowSMSNotify = false
    @State private var allowPromoPushNotify = false
    @State private var isPresented = false
    @State private var showinglogoutSheet = false
    @State var UserData: UserAccount?
    @State var loaded = false
    @EnvironmentObject var partialSheet : PartialSheetManager
    
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                    HStack {
                        Button(action: {
                            isPresented.toggle()
                        } ) {
                            
                            VStack {
                                Image("placeholder-image")
                                    .resizable()
                                    .padding(.all)
                                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.gray)
                                    .cornerRadius(100)
                                
                                if loaded {
                                    Text("\(UserData?.firstName ?? "") \(UserData?.lastName ?? "")")
                                        .font(.system(size: 26.0, weight: .regular, design: .rounded))
                                        .foregroundColor(Color("Text"))
                                        .padding(.top, 5.0)
                                        
                                    Text("\(UserData!.email)")
                                        .font(.system(size: 18.0, weight: .regular, design: .rounded))
                                        .foregroundColor(Color("Sub-Text"))
                                }
                                
                                else {
                                    LoadingView(size: 30)
                                        .padding(.top)
                                }
                            }
                            .padding(.top)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                //Account
                VStack(spacing: 5.0) {
                    NavigationLink(destination: AddressView(addresses: UserData?.address ?? [], loaded: true)) {
                        AccountNavLinkItem(title: "Addresses")
                    }
                    
                    NavigationLink(destination: PaymentList()) {
                        AccountNavLinkItem(title: "Payment methods")
                    }
                    
                    NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                        AccountNavLinkItem(title: "Get $0 Fees with subscription")
                    }
                    
                    NavigationLink(destination: /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                        AccountNavLinkItem(title: "Refer Friends, Get $12.00")
                    }
                }
                .padding([.top, .leading])
                .foregroundColor(Color("Text"))
                Divider()
                
                
                //Notifications
                VStack(alignment: .leading) {
                    Text("Notifications")
                        .font(.system(size: 18.0, weight: .bold, design: .rounded))
                        .padding(.top)
                    
                    Toggle(isOn: $allowPushNotify.onChange(toggled)) {
                        Text("Delivery Push Notifications")
                            .font(.system(size: 18.0, weight: .regular, design: .rounded))
                    }
                    
                    Toggle(isOn: $allowSMSNotify.onChange(toggled)) {
                        Text("Delivery SMS Notifications")
                            .font(.system(size: 18.0, weight: .regular, design: .rounded))
                    }
                    
                    Toggle(isOn: $allowPromoPushNotify.onChange(toggled)) {
                        Text("Promotional Push Notifications")
                            .font(.system(size: 18.0, weight: .regular, design: .rounded))
                    }
                }
                .padding(.horizontal)
                Divider()
                
                
                //More
                VStack(alignment: .leading) {
                    Text("More")
                        .font(.system(size: 18.0, weight: .bold, design: .rounded))
                        .padding(.top)
                    
                    NavigationLink(destination: /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                        AccountNavLinkItem(title: "Become a partner")
                    }
                    
                    Button(action: { showinglogoutSheet = true })
                    {
                        VStack(alignment: .leading) {
                            Text("Sign Out")
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 45, alignment: .leading)
                        }
                        .padding(.bottom)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .actionSheet(isPresented: $showinglogoutSheet) {
                        ActionSheet(title: Text("Are you sure?"), buttons: [
                            .default(Text("Sign out")) { print("logout") },
                            .cancel()
                        ])
                    }
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("Version 1.01")
                            .font(.system(size: 14.0, weight: .regular, design: .rounded))
                            .padding(.bottom)
                        Spacer()
                    }
                }
                .padding(.leading)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("Settings", displayMode: .automatic)
            .foregroundColor(Color("Default-Text"))
            .background(Color("Primary"))
            .overlay(
                UpdateUserView(loaded: $loaded, emaildata: UserData?.email, phone: UserData?.profile?.phone, user: UserData, isShown: $isPresented)
                    .offset(x: 0, y: isPresented ? 0 : 800)
                    .animation(.easeIn(duration: 0.45)))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: { loadData() })
    }
}

struct AccountNavLinkItem: View {
    let title: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 18.0, weight: .regular, design: .rounded))
                    .foregroundColor(Color("Text"))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .frame(width: 30, height: 20)
                .foregroundColor(Color("Sub-Text"))
        }
        .frame(height: 40)
    }
}


//Callback for bindings when the value is changed
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { newValue in
                wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}


//Logic Controllers
extension AccountView {
    func loadData() {
        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/my/account/", for: UserAccount.self, using: .get) { data in
            switch data {
            case .success(let data):
                print("Success")
                UserData = data
                loaded = true
                allowSMSNotify = data.profile!.hasTexts
                allowPushNotify = data.profile!.hasNotifications
                allowPromoPushNotify = data.profile!.hasPromo
                
            default:
                print("error xx")
            }
        }
    }
    
    func toggled(to value: Bool) {
        print("Name changed!")
    }
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .addPartialSheet()
            .environmentObject(PartialSheetManager())
    }
}


struct AccountVCR<Content: View>: UIViewControllerRepresentable {
    var content: () -> Content
    
    func getData() {
        NetworkController.shared.loadData(from: "192.168.1.75:8000/my/account/", for: UserAddress.self, using: .get) { data in
            switch data {
            case .success( _):
                print("Good")
                
            default:
                print("Done")
            }
        }
    }
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIAccountView()
        vc.hostingController.rootView = AnyView(self.content())
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        print("hello")
    }
}


class UIAccountView: UIViewController {
    lazy var container: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        return v
    }()
    var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))
    
    
    override func viewDidLoad() {
        view.addSubview(container)
        pinEdges(of: container, to: view)
        container.addSubview(hostingController.view)
        pinEdges(of: hostingController.view, to: container)
    }
}

