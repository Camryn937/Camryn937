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

struct AddressView: View {
    @State var addresses = [AddressObject]()
    @State var searchText = ""
    @State var loaded = false
    @State var showSheet = false
    @State var editId = 0
    
    var body: some View {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .padding(.trailing, 3.0)
                            TextField("Search for a new address", text: $searchText)
                                .font(.system(size: 20.0, weight: .regular, design: .rounded))
                        }
                        .padding(.all)
                        Seperator()
                        ForEach(0..<addresses.count, id: \.self) { id in
                            HStack {
                                Image(systemName: "mappin.circle")
                                    .foregroundColor(.gray)
                                VStack(alignment: .leading) {
                                    Text("\(addresses[id].address.address1) \(addresses[id].address.address2 ?? "")")
                                        .font(.system(size: 18.0, weight: .semibold, design: .rounded))

                                    Text("\(addresses[id].address.area.city), \(addresses[id].address.area.state) \(addresses[id].address.area.zipCode)")
                                        .font(.system(size: 14.0, weight: .regular, design: .rounded))
                                        .foregroundColor(Color("Sub-Text"))
                                }
                                .padding(.vertical)
                                Spacer()
                                Button(action: {
                                    editId = id
                                    showSheet.toggle()
                                }) {
                                    Text("Edit")
                                        .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                        .foregroundColor(Color.blue)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .sheet(isPresented: $showSheet) {
                    EditAddressView(address: addresses[editId])
                }
            .background(Color("Primary"))
                .onAppear {
                    if !loaded {
                        NetworkController.shared.loadData(from: "http://localhost:8000/my/account/", for: UserAccount.self, using: .get) { data in
                            switch data {
                            case .success(let data):
                                print("Success")
                                addresses = data.address ?? []
                                return true
                                
                            default:
                                print("error xx")
                                return false
                            }
                        }
                    }
            }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
