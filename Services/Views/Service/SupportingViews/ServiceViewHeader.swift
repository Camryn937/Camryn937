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

struct ServiceViewHeader: View {
    @Binding var isSubscribable: Bool
    @Binding var transport: Bool
    @Binding var selected: Int
    @Binding var showSheet: Bool
    var canMessage: Bool
    var canSub: Bool
    var hasQuote: Bool
    var name: String
    var isVerified: Bool
    var hasDelivery = true
    var hasDropoff = true
    @EnvironmentObject var partialSheet : PartialSheetManager
    
    var body: some View {
        VStack(spacing: 0.0) {
            Image("placeholder-image")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 220, alignment: .top)
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                        .font(.system(size: 28.0, weight: .semibold, design: .rounded))
                    
                    if isVerified { Image(systemName: "xmark") }
                }
                .padding(.vertical, 5.0)
                
                Group {
                    Text("2000+ Ratings")
                        .font(.system(size: 12.0, weight: .medium, design: .rounded))
                        .foregroundColor(Color.gray)
                    
                    Text("\(UIScreen.main.bounds.height)")
                        .font(.system(size: 12.0, weight: .medium, design: .rounded))
                        .foregroundColor(Color.gray)
                }
                .padding(.bottom, 1.0)
                
                HStack {
                    Group {
                        if !isSubscribable {
                            Button(action: {
                                partialSheet.showPartialSheet({
                                    print("dismissed")
                                }) { Text("Partial SheetView!")
                                    .frame(height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }
                            }, label: { ServiceHeaderButton(label: "Subscribe") })
                        }
                        if canMessage {
                            NavigationLink(destination: Text("hello")) {
                                ServiceHeaderButton(label: "Send Message")
                                .padding(.top, 3.0)
                            }
                        }
                    }
                }
            }
            .padding([.leading, .bottom, .trailing])
            
            ServiceSectionPicker(selected: $selected)
        }
//        .frame(maxHeight: UIScreen.main.bounds.height, alignment: .bottom)
        .background(Color("Primary"))
    }
}

struct ServiceViewObjectsWrapper: View{
    @State var prop = true
    @State var selected = 0
    var body: some View {
        ServiceViewHeader(isSubscribable: $prop, transport: $prop, selected: $selected, showSheet: $prop, canMessage: true, canSub: true, hasQuote: true, name: "Name", isVerified: true)
    }
}
struct ServiceViewObjects_Previews: PreviewProvider {
    static var previews: some View {
        ServiceViewObjectsWrapper()
    }
}

struct ServiceHeaderButton: View {
    var label = ""
    var body: some View {
        Text(label)
            .font(.system(size: 14.0, weight: .medium, design: .rounded))
            .frame(maxWidth: .infinity)
            .foregroundColor(Color("Text"))
            .padding(.all)
            .frame(height: 40, alignment: .center)
            .background(Color("Primary"))
            .overlay( RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 0.5))
    }
}

struct ServiceHeaderInfoSegment: View {
    var eta = ""
    var distance = ""
    var body: some View {
        HStack {
            Spacer()
            Text(distance)
                .font(.system(size: 14.0, weight: .semibold, design: .rounded))
            Spacer()
            Divider().padding(.vertical)
            Spacer()
            Text(eta)
                .font(.system(size: 14.0, weight: .semibold, design: .rounded))
            Spacer()
        }
        .foregroundColor(Color("Default-Text"))
        .cornerRadius(5)
        .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(hue: 1.0, saturation: 0.024, brightness: 0.61, opacity: 0.699), lineWidth: 1))
        .frame(height:60)
    }
}
