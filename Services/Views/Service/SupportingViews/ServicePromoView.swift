///// Copyright (c) 2020 Capsule LLC
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
//
//  Services
//
//  Created by: Camryn Crowder on 1/10/21
//  Copyright © 2021 Capsule. All rights reserved.
//

import SwiftUI
import PartialSheet

struct ServicePromoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("DashPass")
                .padding(.top)
                .font(.system(size: 16.0, weight: .bold, design: .rounded))
            
            Text("New benfit: Earn 5%")
                .font(.system(size: 20.0, weight: .bold, design: .rounded))
            
            Text("credit back on Pickup")
                .font(.system(size: 18.0, weight: .medium, design: .rounded))
            
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: 110, height: 33)
                    .overlay(Text("Learn More")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                    )
            }
            .padding(.bottom)
        }
        .padding(.all)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 145)
        .background(Color.red)
    }
}

struct ServicePromoView_Previews: PreviewProvider {
    static var previews: some View {
        ServicePromoView()
    }
}

struct FeaturedServiceView: View {
    @ObservedObject var order: Order
    @State var services: [Service]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Group {
                Text("National Favorites")
                    .font(.system(size: 22.0, weight: .semibold, design: .rounded))
            }
            .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0.0) {
                    ForEach(services, id: \.self) { service in
                        //Navigate to the nearest location in the index
						NavigationLink(destination: ServiceView(id: service.id)) {
                            VStack(spacing: 5.0) {
                                Group {
                                    Image("placeholder-image")
                                        .resizable()
                                        .background(Color.blue)
                                        .cornerRadius(6)
                                }
                                .padding(.horizontal)
                                HStack(spacing: 2.0) {
                                    VStack(alignment: .leading) {
                                        Text(service.name)
                                            .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                                            .foregroundColor(Color("Text"))
                                        Text("")
                                            .font(.system(size: 14.0, weight: .medium, design: .rounded))
                                            .foregroundColor(Color("Default-Text"))
                                            .padding(.bottom, 7.0)
                                    }
                                }
                            }
                            .padding(.vertical)
                            .frame(maxWidth: 300 ,maxHeight: 225)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    NavigationLink(destination: AllServiceListView(order: order, services: services).environmentObject(PartialSheetManager())) {
                        VStack(alignment: .center, spacing: 5.0) {
                            Group {
                                Image("placeholder-image")
                                    .resizable()
                                    .background(Color.blue)
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .cornerRadius(100)
                            }
                            .padding(.horizontal)
                            HStack(spacing: 2.0) {
                                    Text("See More")
                                        .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color("Text"))
                                        .padding(.trailing, 4.0)
                                Image(systemName: "arrow.forward")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 12, height: 12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.vertical)
                        .frame(maxWidth: 300 ,maxHeight: 225)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct PopularServiceView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedServiceView(order: Order(), services: [Service(id: 1, name: "Chick-fil-A®", imageURL: "https://via.placeholder.com/300", location: Optional([Services.Location(id: 18), Services.Location(id: 17), Services.Location(id: 20)])), Service(id: 1, name: "Chick-fil-A®", imageURL: "https://via.placeholder.com/300", location: Optional([Services.Location(id: 18), Services.Location(id: 17), Services.Location(id: 20)])), Service(id: 1, name: "Chick-fil-A®", imageURL: "https://via.placeholder.com/300", location: Optional([Services.Location(id: 18), Services.Location(id: 17), Services.Location(id: 20)]))])
    }
}
