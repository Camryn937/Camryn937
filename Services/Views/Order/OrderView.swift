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

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}


struct OrderView: View {
    @State private var items = ["laundry","stuff","more stuff","extra", "laundry","stuff","more stuff","extra", "more stuff","extra"]
    @State var inProgress = false
    var body: some View {
        NavigationView {
            ScrollView {
                if inProgress {
                    NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                        ActiveOrderView()
                            .padding(.all)
                    }
                }
                VStack(alignment: .leading) {
                    ForEach(self.items, id: \.self) { item in
                        VStack {
                            HStack(alignment: .center) {
                                NavigationLink(destination: OrderDetail()) {
                                    Image("default")
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .cornerRadius(100)
                                        .overlay(Circle()
                                                    .stroke(Color.gray, lineWidth: 1))
                                    
                                    VStack(alignment: .leading) {
                                        Text(item)
                                            .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                                            .foregroundColor(Color("Text"))
                                        Text("Aug 19th")
                                            .font(.system(size: 14.0, weight: .medium, design: .rounded))
                                            .foregroundColor(Color.gray)
                                            .padding([.bottom, .trailing], 4.0)
                                        Spacer()
                                    }
                                    .padding(.leading)
                                    Spacer()
                                    VStack {
                                        Text("$79.59")
                                    }.padding(.trailing)
                                    .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding([.leading, .bottom])
                        }
                    }
                }
                .padding(.top)
                Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Load More")
                        .font(.system(size: 16.0, weight: .medium, design: .rounded))
                        .padding(.all)
                }
            }
            .navigationBarTitle("Order", displayMode: .automatic)
        }
    }
}


struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}


extension OrderView {
    //    func uploadOrder() {
    //        let data = convert(list: order.selectedItems)
    //        let parameters: Parameters = ["item": serviceItem.id, "choices": data]
    //        if user.auth == nil {
    //            user.authLogin()
    //        }
    //        AF.request("http://172.16.0.3:8000/service/cart/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: user.getHeader())
    //            .responseJSON { response in
    //                //Need to program retry after failure
    //                switch response.result {
    //                case .success( _):
    //                    do {
    //                        print(response)
    //                        self.isShown = false
    //                    }
    //                case .failure(let error):
    //                    print(error)
    //                }
    //            }
    //    }
}
