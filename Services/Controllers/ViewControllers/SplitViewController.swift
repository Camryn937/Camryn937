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
//  Created by: Camryn Crowder on 2/26/21
//  Copyright © 2021 Capsule. All rights reserved.
//

import SwiftUI

import Foundation
import UIKit

let topViewHeight: CGFloat = 400
var containerHeight: CGFloat = 0

//MARK:- SplitViewController
//// Controls the scrollview between the bottomVC and the topVC offset position based on scroll offset
class SplitViewController: UIViewController, BottomViewControllerScrollDelegate {

    let topVC: TopViewController = TopViewController()
    let bottomVC: BottomViewController = BottomViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        bottomVC.delegate = self
        addViewController(bottomVC, frame: view.bounds, completion: nil)
        addViewController(topVC, frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: topViewHeight), completion: nil)
        
        topVC.view.frame.origin.y = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    func bottomViewScrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = (scrollView.contentOffset.y + topViewHeight)
        print(offset)
        if offset >= 0 {
            topVC.view.frame.origin.y = -(scrollView.contentOffset.y + topViewHeight)
        }
    }
}

class TopViewController: UIViewController {
    var hc: UIHostingController<AnyView> = UIHostingController(rootView:AnyView(EmptyView()))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        addViewController(hc, frame: view.bounds, completion: nil)
    }
}

protocol BottomViewControllerScrollDelegate: class {
    func bottomViewScrollViewDidScroll(_ scrollView: UIScrollView)
}

//MARK: - BottomVC PageViewController
// Page View Controller which pages through scrolling collection views

class BottomViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    lazy var content: PageViewController = {
        let vc = PageViewController()
        vc.delegate = self
        vc.dataSource = self
        vc.view.backgroundColor = .clear
        vc.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-40)
        return vc
    }()
    
    //Controlls scrolling between the child and container view
    //gets passed to splitVC
    weak var delegate: BottomViewControllerScrollDelegate?
    
    
    var identifiers: NSArray = ["Service", "Review", "Photos", "About"]
    
    let serviceVC = ServiceViewController()
    let reviewVC = ServiceViewController()
    let aboutVC = ServiceViewController()
    let photoVC = ServiceViewController()
    
    
    //list of child controllers to page through
    public var Controllers: [UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        serviceVC.delegate = delegate

        reviewVC.delegate = delegate
        
        aboutVC.delegate = delegate
        
        photoVC.delegate = delegate

        Controllers = [serviceVC, reviewVC, photoVC, aboutVC]

        content.setViewControllers([serviceVC], direction: .forward, animated: true, completion: nil)
        addViewController(content, frame: view.bounds, completion: nil)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    
    //relay scroll info to parent controller
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.bottomViewScrollViewDidScroll(scrollView)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = Controllers!.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
                
        guard nextIndex >= 0 else { return nil }
        
        guard Controllers!.count > nextIndex else { return nil }
        
        let controller = Controllers![nextIndex]
        
        return controller
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = Controllers!.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
                    
        guard previousIndex >= 0 else { return nil }
        
        guard Controllers!.count > previousIndex else { return nil }
        
        let controller = Controllers![previousIndex]
        
        return controller
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return self.identifiers.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return 0
    }
}

extension UIViewController {

    func addViewController(_ viewController: UIViewController, frame: CGRect, completion: (()-> Void)?) {
        viewController.willMove(toParent: self)
        viewController.beginAppearanceTransition(true, animated: false)
        addChild(viewController)
        viewController.view.frame = frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        viewController.endAppearanceTransition()
        completion?()
    }
}

