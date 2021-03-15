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
//  Created by: Camryn Crowder on 1/8/21
//  Copyright © 2021 Capsule. All rights reserved.
//

import SwiftUI

struct EditAddressView: View {
    var address: AddressObject
    @State var aptField = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
                Image(systemName: "trash")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 20, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .padding([.top, .leading, .trailing])
            ScrollView {
                Text("")
                    .frame(height: 200, alignment: .center)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                
                VStack(alignment: .leading) {
                    
                    Group {
                        Text("\(address.address.address1) \(address.address.address2 ?? "")")
                            .font(.system(size: 18.0, weight: .bold, design: .rounded))
                            .foregroundColor(Color("Text"))
                            .padding(.bottom, 3.0)
                        Text("\(address.address.area.city), \(address.address.area.state) \(address.address.area.zipCode), \(address.address.country)")
                            .font(.system(size: 18.0, weight: .medium, design: .rounded))
                            .foregroundColor(Color("Text"))
                        
                        HStack {
                            Text("Apt/Suite")
                                .font(.system(size: 18.0, weight: .bold, design: .rounded))
                                .foregroundColor(Color("Text"))
                                .padding(.trailing)
                            
                            TextField("Apt 123", text: $aptField)
                        }
                    }
                    .padding([.top, .leading, .trailing])
                    
                    Seperator()
                    
                    Group {
                        Text("Delivery Options")
                            .font(.system(size: 18.0, weight: .bold, design: .rounded))
                            .foregroundColor(Color("Text"))
                            .padding(.vertical)
                        
                        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Button")/*@END_MENU_TOKEN@*/
                        }
                        
                        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Button")/*@END_MENU_TOKEN@*/
                        }
                        
                        Divider()
                        
                        Text("Special instructions")
                            .font(.system(size: 18.0, weight: .bold, design: .rounded))
                            .padding(.vertical)
                        
                    }
                    .padding(.leading)
                }
                
            }
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Save Address")
            }
        }
    }
}

struct EditAddressViewWrapper: View {
    var address = AddressObject(id: 1, isDefault: true, address: UserAddress(id: 1, address1: "47 Leroy st", address2: "C", country: "US", area: Area(id: 1, zipCode: "45402", city: "Dayton", state: "OH", timezone: ""), geo: ""))
    
    var body: some View {
        EditAddressView(address: address)
    }
}



struct EditAddressView_Previews: PreviewProvider {
    static var previews: some View {
        EditAddressViewWrapper()
    }
}
