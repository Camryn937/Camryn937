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
//
//  ContentView.swift
//  Container
//
//  Created by Camryn Crowder on 12/23/20.
//

import SwiftUI
import Alamofire
import PartialSheet

struct ServiceView: View {
    @State private var service = [ServiceData]()

    //Add ability to change location by ID
    @State private var delivery = false //User selects if they want delivered
    @State var showingSubscription = false
    @State var showingSheet = false
    @State var selected = 0 //Manages tabbed view for Reviews, About, Service List etc....
    let isVerified = true
    let id: Int
    @State var loaded = false
    @EnvironmentObject var partialSheetManager : PartialSheetManager
    
    var body: some View {
        if loaded {
            UIServiceView(order: Order(), serviceItems: service.first!.serviceItems)
            .background(Color("Primary"))
//                .edgesIgnoringSafeArea(.top)
        }
        
        else {
            AnimationCircleStrokeSpin(size: 30)
                .padding(.all)
                .onAppear(perform: { loadData() })
        }
    }
}

extension UIViewController {
    func pinEdges(of viewA: UIView, to viewB: UIView) {
        viewA.translatesAutoresizingMaskIntoConstraints = false
        viewB.addConstraints([
            viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
            viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
            viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
            viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
        ])
    }
}

#if DEBUG
struct SampleUIScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView(id: 18)
            .addPartialSheet()
            .environmentObject(PartialSheetManager())
    }
}
#endif


extension ServiceView {
    func loadData() {
        NetworkController.shared.loadData(from: "http://192.168.1.75:8000/service/1/", for: ServiceData.self, using: .get) { response in
            switch response {
            case .success(let data):
                service = [data]
                loaded = true
                
            default:
                print("done xxxxxxx")
            }
        }
    }
}
