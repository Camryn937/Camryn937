///// Copyright (c) 2020 Capsule LLC
/////
///// Permission is hereby granted, free of charge, to any person obtaining a copy
///// of this software and associated documentation files (the "Software"), to deal
///// in the Software without restriction, including without limitation the rights
///// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
///// copies of the Software, and to permit persons to whom the Software is
///// furnished to do so, subject to the following conditions:
/////
///// The above copyright notice and this permission notice shall be included in
///// all copies or substantial portions of the Software.
/////
///// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
///// distribute, sublicense, create a derivative work, and/or sell copies of the
///// Software in any work that is designed, intended, or marketed for pedagogical or
///// instructional purposes related to programming, coding, application development,
///// or information technology.  Permission for such use, copying, modification,
///// merger, publication, distribution, sublicensing, creation of derivative works,
///// or sale is expressly withheld.
/////
///// This project and source code may use libraries or frameworks that are
///// released under various Open-Source licenses. Use of those libraries and
///// frameworks are governed by their own individual licenses.
/////
//
import SwiftUI
import PartialSheet

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            MainContent()
            Button(action: {
                
            }) {
                VStack {
                    HStack {
                        Text("Cart $25.00")
                            .foregroundColor(Color.white)
                            .font(.system(size: 18.0, weight: .semibold, design: .rounded))
                            .frame(height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
            }

//                .onAppear(perform: {
//                    loadData()
//                })
        }
    }
//    func loadData() {
//        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/service/", for: [Service].self, using: .get) { data in
//            switch data {
//            case .success(let data):
//            default:
//                print("failure xx")
//            }
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PartialSheetManager())
    }
}


//
//let fontFamilyNames = UIFont.familyNames
//
//for familyName in fontFamilyNames {
//    print("------------------------------")
//    print("Font Family Name = [\(familyName)]")
//
//    let names = UIFont.fontNames(forFamilyName: familyName)
//    print("Font Names = [\(names)]")
//}


