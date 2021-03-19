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


struct ServiceItemView: View {
    let edit: Bool
    let itemHeader: ServiceData.ServiceItem
    
    @State var serviceItem: ServiceItemData?
    @ObservedObject var order: Order
    
    @Binding var isShown: Bool // Controls the popup being displayed
    @State var requiredCount = 1 // Counts the number of elements required before being complete
    let locationId: Int // Used to verify order integrity
    
    @State var proxy: ScrollViewProxy? = nil
    @State var incompleteID = 0 //Element to scroll to if it is not completed
    
    @State var loading = false //Waits for the uploading to succeed
    @State var loaded = false
    @State var locked = false //Prevents changes while uploading order
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) { proxy in
                
                //Image View With Item description
                ServiceItemHeader(service: serviceItem?.serviceItem ?? itemHeader)
                Seperator()
                
                if loaded {
                    
                    //loops through the option list field to generate the card header & choices
                    //Uses required count to make sure all required items completed
                    ForEach(serviceItem!.orderOption, id:\.self) { option in
                        ServiceItemCard(incompletedID: $incompleteID, requiredCount: $requiredCount, order: order, serviceItem: option.choices, callback: canProceed, option: option, locked: $locked)
                            .scrollId(incompleteID)
                        Seperator()
                    }
                    .onAppear { self.proxy = proxy }
                    
                    //Quantity Button
                    Group {
                        HStack {
                            Button(action: {
                                if order.qty != 1 {
                                    order.qty -= 1
                                    order.update()
                                }
                            }) {
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .frame(width: 22, height: 22, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .padding(.trailing)
                            }
                            
                            Text("\((order.qty), specifier: "%.0f")")
                                .padding(.vertical, 4.0)
                                .padding(.horizontal)
                                .font(.system(size: 24.0, weight: .regular, design: .rounded))
                                .foregroundColor(Color("Text"))
                                .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("Text"), lineWidth: 1))
                            
                            Button(action: {
                                if !order.selectedItems.isEmpty {
                                    order.qty += 1.0
                                    order.update()
                                }
                            }) {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 22, height: 22, alignment: .center)
                                    .padding(.leading)
                            }
                        }
                        .frame(width: 400, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                }
                
                else {
                    VStack {
                        AnimationCircleStrokeSpin(size: 30)
                    }
                    .frame(height: 200)
                    .onAppear(perform: {
						loadData()
						order.selectedService = [itemHeader]
						order.update()
					})
                }
                
            }
            
            //Add to cart button
            Group {
                Button(action: {
                    self.proxy?.scrollTo(incompleteID, alignment: .top)
                    
                    if requiredCount > 0 {
                        impactMed.impactOccurred()
                    }
                    
                    if requiredCount == 0 && !loading {
                        locked = true
                        loading = true
                        order.uploadOrder(asUpdate: edit)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
                            if order.isUploaded {
                                locked = false
                                loading = false
                                isShown = false
                            }
                            else {
                                locked = false
                                loading = false
                            }
                        }
                    }
                }) {
                    //Order Button
                        HStack {
                            Spacer()
                            if loading { AnimationCircleStrokeSpin(size: 25) }
                            
                            else {
                                Text(!edit ? "Continue $\((order.total), specifier: "%.2f")" :
                                        "Add to cart - $\((order.total), specifier: "%.2f")")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.white)
                            }
                            
                            Spacer()
                        }
                        .foregroundColor(Color("Text"))
                        .padding(.all, 16.0)
                        .background( requiredCount == 0 ? Color.blue : Color.gray.opacity(0.5) )
                        .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

#if DEBUG
struct ServiceItemWrapperView: View {
    var order = Order()
    @State var isShown = true
    let some = true
    
    var body: some View {
		ServiceItemView(edit: true, itemHeader: Services.ServiceData.ServiceItem(id: 1, name: "Laundry", imageURL: "https://a0.muscache.com/im/pictures/75e5eca4-17b1-4264-80e3-574740b08f51.jpg?im_w=1200", description: "We are a full-service cleaners, offering professional dry cleaning services, shirt laundering, repairs, alterations, family and campus laundry bundles. Just contact one of our two locations today and we’ll handle all of your dry cleaning and laundry needs in a professional and timely manner.", price: 0.0), order: order, isShown: $isShown, locationId: 4)
    }
}

struct ServiceItemWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceItemWrapperView()
            .previewLayout(.sizeThatFits)
            .environmentObject(AuthUser())
    }
}
#endif

extension ServiceItemView {
    func loadData() {
        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/service/\(itemHeader.id)/1/",
                                          for: ServiceItemData.self, using: .get) { response in
            switch response {
            case .success(let data):
                serviceItem = data
                requiredCount = 0
                
                for item in data.orderOption {
                    if item.min_options > 0 {
                        self.requiredCount += 1
                    }
                }
                
                loaded = true
                
            default:
                print("done xxxxxxx \(response)")
            }
        }
        
    }
    
    
    func canProceed() {
        print("Call Back")
    }
}

