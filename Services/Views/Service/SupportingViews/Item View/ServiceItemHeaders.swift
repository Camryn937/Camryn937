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

//ServiceItemView Header
struct ServiceItemHeader: View {
    var service: ServiceData.ServiceItem
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        //Load header image
        VStack(spacing: 0.0) {
            AsyncImage(url: URL(string: service.imageURL!)!, cache: self.cache, placeholder: defaultImage() , configuration: { $0.resizable() }, mode: 2)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200)
            
            VStack(alignment: .leading) {
                Group {
                    Text(service.name)
                        .font(.system(size: 24.0, weight: .semibold, design: .rounded))

                        .foregroundColor(Color("Text"))
                    
                    Text(service.description)
                        .font(.system(size: 14.0, weight: .regular, design: .rounded))

                        .foregroundColor(Color("Default-Text"))
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 3.0)
                }
            }.padding(.all)
        }
    }
}

struct Seperator: View {
    var body: some View {
        Rectangle()
            .fill(Color("Accent-Color"))
            .frame(height: 8, alignment: .top)
            .overlay(
                Rectangle().stroke(Color("Shadow"), lineWidth: 2))
    }
}

struct  SeperatorWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Seperator()
        }
    }
}

//Default image before image is loaded with matching background color to keep aspect 1:1
struct defaultImage: View {
    var body: some View {
        Image("default")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color("Primary"))
    }
}
struct StickyHeader<Content: View>: View {
    
    var minHeight: CGFloat
    var content: Content
    
    init(minHeight: CGFloat = 200, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geo in
            if(geo.frame(in: .global).minY <= 0) {
                self.content
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            } else {
                self.content
                    .offset(y: -geo.frame(in: .global).minY)
                    .frame(width: geo.size.width, height: geo.size.height )
            }
        }.frame(minHeight: minHeight)
    }
}

struct StaticContent<Content: View>: View {
    
    var minHeight: CGFloat
    var content: Content
    
    init(minHeight: CGFloat = 200, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geo in
            if(geo.frame(in: .global).minY >= 0) {
                self.content
            } else {
                self.content
                //                    .offset(y: geo.frame(in: .global).minY)
            }
        }
    }
}


#if DEBUG
struct ServiceItemHeaderWrapper: View {
    var service = ServiceItemData(serviceItem: Services.ServiceData.ServiceItem(id: 1, name: "Laundry", imageURL: Optional("https://a0.muscache.com/im/pictures/75e5eca4-17b1-4264-80e3-574740b08f51.jpg?im_w=1200"), description: "We are a full-service cleaners, offering professional dry cleaning services, shirt laundering, repairs, alterations, family and campus laundry bundles. Just contact one of our two locations today and we’ll handle all of your dry cleaning and laundry needs in a professional and timely manner."), optionList: [Services.OptionsList(id: 1, name: "Include Laundry Bag", is_required: false, options: [Services.OptionsList.Options(id: 1, name: "Yes", has_options: false, amount: 3, price: 4.50)], min_options: 0, max_options: 1), Services.OptionsList(id: 2, name: "What Detergent Should We Use", is_required: true, options: [Services.OptionsList.Options(id: 2, name: "Tide", has_options: false, amount: 2, price: 4.50), Services.OptionsList.Options(id: 3, name: "Gain", has_options: false, amount: 5, price: 2.00)], min_options: 1, max_options: 1), Services.OptionsList(id: 3, name: "Please Select A Fabric Softener", is_required: true, options: [Services.OptionsList.Options(id: 4, name: "Snuggle", has_options: false, amount: 3, price: 7.00), Services.OptionsList.Options(id: 5, name: "Angel Soft", has_options: false, amount: 3, price: 6.00)], min_options: 1, max_options: 2)], quantity: 1, message: "")
    
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        //Load header image
        VStack {
            ServiceItemHeader(service: service.serviceItem)
            Seperator()
        }
    }
}
struct  ServiceItemHeaderWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ServiceItemHeaderWrapper()
            .previewLayout(.sizeThatFits)
    }
}
#endif
