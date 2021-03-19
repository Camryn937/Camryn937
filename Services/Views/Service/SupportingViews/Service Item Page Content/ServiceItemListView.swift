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

//View that lists all the services available for a particular service location
struct ServiceItemListView: View {
    @Environment(\.imageCache) var cache: ImageCache
    let serviceItems: [ServiceData.ServiceItem]
    @State var showingDetail = false
    @ObservedObject var order: Order
    //Used to set the order object to prevent
    //other locations from being ordered
    let locationId: Int
    let hasQty = true
    let isSub = true
    let allowsImage = true
    let vid = 0
    
    var body: some View {
        if serviceItems.count > 0 {
            VStack(alignment: .leading, spacing: 0.0)  {
                ForEach(serviceItems, id:\.self) { serviceItem in
                    VStack(spacing: 0.0) {
                        Button(action: {
                            showingDetail.toggle()
                        })
                        {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text(serviceItem.name)
                                        .font(.system(size: 18))
                                        .fontWeight(.semibold)
									Spacer()
									Text("$\((serviceItem.price), specifier: "%.2f")")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .padding(.top, 1.0)
                                }
								.padding(.all)
                                
                                Spacer()
                                
                                AsyncImage(url: URL(string: serviceItem.imageURL!)!, cache: self.cache, placeholder: Text("Loading ..."), configuration: { $0.resizable() }, mode: 2)
                                    .scaledToFit()
                                    .aspectRatio(2, contentMode: .fill)
                                    .frame(width: 140, height: 120)
                            }
                            .frame(height: 120.0)
                            .sheet(isPresented: $showingDetail, onDismiss: order.cancel) {
                                ServiceItemView(edit: false, itemHeader: serviceItem, order: order, isShown: $showingDetail, locationId: locationId)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider().padding([.leading])
                    }
                }
                Spacer()
                        MenuIssueButton()
                    .background(Color("Primary"))
            }
            .frame(width: UIScreen.main.bounds.width)
            .frame(minHeight: UIScreen.main.bounds.height)
        }
        else {
            SpinnerWrapper()
                .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

#if DEBUG
struct ServiceListViewWrapper: View {
    @State var delivery = true
    func testeroo(height: CGFloat, n: Int) {
        print("hi")
    }
	@State private var serviceItems = [ServiceData.ServiceItem(id: 1, name: "Laundry", imageURL: "https://via.placeholder.com/300", description: "We are a full-service cleaners, offering professional dry cleaning services, shirt laundering, repairs, alterations, family and campus laundry bundles. Just contact one of our two locations today and we’ll handle all of your dry cleaning and laundry needs in a professional and timely manner.", price: 0.0)]
    @State var isShown = true
    var body: some View{
        Group {
            ServiceItemListView(serviceItems: self.serviceItems, order: Order(), locationId: 18)
        }
    }
}

struct ServiceListWrapper_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ServiceListViewWrapper()
                .previewLayout(.sizeThatFits)
        }
    }
}

#endif
