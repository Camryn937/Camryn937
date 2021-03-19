////
////  ContentViewController.swift
////  Services
////
////  Created by Camryn Crowder on 1/5/21.
////  Copyright © 2021 Capsule. All rights reserved.
////
//
//import UIKit
//import SwiftUI
//
//
//class ContentViewController:  UIViewController, UIScrollViewDelegate {
//        
//    lazy var container: UIView = {
//        let v = UIView()
//        v.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        v.backgroundColor = .white
//        v.clipsToBounds = true
//        
//        return v
//    }()
//    
//    lazy var hostController: UIHostingController<AnyView> = {
//        let vc = UIHostingController<AnyView>()
//
//        return vc
//    }()
//    
////    lazy var footer: UIView = {
////        let v = UIView()
////        v.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
////        v.backgroundColor = .red
////        v.clipsToBounds = true
////
////        return v
////    }()
//    
//    var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(container)
//        
////        view.addSubview(footer)
////        footer.translatesAutoresizingMaskIntoConstraints = false
////        NSLayoutConstraint.activate([
////            footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
////            footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
////            footer.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height-80),
////            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
////        ])
//    }
//    
//    var vcHieght = [CGFloat]()
//}
