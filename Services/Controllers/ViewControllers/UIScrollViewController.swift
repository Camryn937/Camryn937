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
////
////  UIScrollViewController.swift
////  Services
////
////  Created by Camryn Crowder on 1/5/21.
////  Copyright © 2021 Capsule. All rights reserved.
////
//
//import UIKit
//import SwiftUI
//
////MARK: - ScrollViewController
//class UIScrollViewVC: UIViewController, UIScrollViewDelegate {
//
//    //UIScroll View used to manage the child SwiftUIView in order to get the content height
//    //for sizing the parent cell
//    lazy var mainScrollView: UIScrollView = {
//        let v = UIScrollView()
//        v.showsHorizontalScrollIndicator = true
//        v.delegate = self
//        v.isDirectionalLockEnabled = true
//        v.backgroundColor = UIColor(named: "Primary")
//        v.showsVerticalScrollIndicator = false
//        v.bounces = true
//        v.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        v.clipsToBounds = false
//        v.backgroundColor = .red
//        v.isScrollEnabled = true
//        
//        return v
//    }()
//    
//    lazy var container: UIView = {
//        let v = UIView()
//        v.backgroundColor = .blue
//
//        return v
//    }()
//    
//    var hc: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(ReviewView()))
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.addSubview(mainScrollView)
//        pinEdges(of: mainScrollView, to: view)
//
//        addChild(hc)
//        
//        mainScrollView.addSubview(container)
//        
//        container.addSubview(hc.view)
//        hc.didMove(toParent: self)
//
//        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            container.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
//            container.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
//            container.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
//        ])
//        
//        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            hc.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
//            hc.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
//            hc.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
//        ])
//        pinEdges(of: container, to: mainScrollView)
//        pinEdges(of: hc.view, to: container)
//    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(container.frame.height)
//    }
//}
//
//
//struct ReviewView_Previews2: PreviewProvider {
//    static var previews: some View {
//        UITestReviewView()
//    }
//}
//
//
//
//struct UITestReviewView: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UIScrollViewVC {
//        let vc = UIScrollViewVC()
//        
//        return vc
//    }
//    
//    func updateUIViewController(_ viewController: UIScrollViewVC, context: Context) {
//    }
//}
