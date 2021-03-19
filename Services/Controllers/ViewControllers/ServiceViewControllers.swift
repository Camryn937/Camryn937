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
//  Created by: Camryn Crowder on 2/4/21
//  Copyright © 2021 Capsule. All rights reserved.
//

import SwiftUI

//MARK: - Collection View Controller
//Holds the page content
class ServiceViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var contentHeight: CGFloat = 0
    var lastPosition: CGFloat = 0
    
    weak var delegate: BottomViewControllerScrollDelegate?

    var hc: UIHostingController<AnyView> = UIHostingController(rootView:AnyView(EmptyView()))
    
    lazy var mainScrollView: UIScrollView = {
        let v = UIScrollView()
        v.showsHorizontalScrollIndicator = true
        v.delegate = self
        v.isDirectionalLockEnabled = true
        v.backgroundColor = UIColor(named: "Primary")
        v.showsVerticalScrollIndicator = false
        v.bounces = true
        v.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        v.clipsToBounds = false
        v.backgroundColor = .white
        v.isScrollEnabled = false
        
        return v
    }()
    lazy var container: UIView = {
        let v = UIView()
        v.backgroundColor = .white

        return v
    }()
    lazy var layout: UICollectionViewFlowLayout = {
        let cv = UICollectionViewFlowLayout()
        cv.minimumInteritemSpacing = 0
        cv.minimumLineSpacing = 0
        cv.scrollDirection = .vertical
        cv.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cv
    }()
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.alwaysBounceVertical = true
        cv.backgroundColor = .clear
        cv.contentInset.top = topViewHeight 
        cv.verticalScrollIndicatorInsets.top = topViewHeight
        cv.dataSource = self
        cv.delegate = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
       return cv
    }()

    override func viewWillAppear(_ animated: Bool) {
        //Syncs all the sibling VC to match the container height or position
        
        print("\(containerHeight)-------")
        
        if containerHeight <= -50 {
            collectionView.contentOffset.y = containerHeight
            collectionView.setContentOffset(CGPoint(x: 0, y: containerHeight), animated: false)

        }
        else if containerHeight >= -50 && lastPosition <= -50 {
            collectionView.contentOffset.y = -50
            collectionView.setContentOffset(CGPoint(x: 0, y: -50), animated: false)

        }
        else if lastPosition >= -50 || lastPosition != containerHeight {
            collectionView.contentOffset.y = lastPosition
            collectionView.setContentOffset(CGPoint(x: 0, y: lastPosition), animated: false)

        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if contentHeight == 0 {
            collectionView.setContentOffset(CGPoint(x: 0, y: -50), animated: true)
        }
        containerHeight = collectionView.contentOffset.y
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        lastPosition = collectionView.contentOffset.y
        containerHeight = collectionView.contentOffset.y
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    //Number of cells to display only one fullscreen cell needed
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    //configure the cellView to host the scrollView and the contents from the SwiftView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.addSubview(mainScrollView)

        pinEdges(of: mainScrollView, to: cell)

        mainScrollView.addSubview(container)
        addChild(hc)
        container.addSubview(hc.view)

        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            container.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
        ])
        NSLayoutConstraint.activate([
            hc.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            hc.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            hc.view.topAnchor.constraint(equalTo: container.topAnchor),
        ])
        
        pinEdges(of: container, to: mainScrollView)
        pinEdges(of: hc.view, to: container)
        
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.bottomViewScrollViewDidScroll(scrollView)
        
        //Adjust the bottom view to match its contents
        if contentHeight != container.frame.height {
            layout.estimatedItemSize = CGSize(width: view.frame.width, height: container.frame.height)
            contentHeight = container.frame.height
        }
        
        containerHeight = scrollView.contentOffset.y
        
        print(containerHeight)
    }
}


struct UIServiceView: UIViewControllerRepresentable {
    @ObservedObject var order: Order
    let serviceItems: [ServiceData.ServiceItem]
    @State var loaded = false

    func makeUIViewController(context: Context) -> SplitViewController {
        let vc = SplitViewController()
        vc.bottomVC.serviceVC.hc.rootView = AnyView(ServiceItemListView(serviceItems: serviceItems, order: order, locationId: 1))
        vc.bottomVC.reviewVC.hc.rootView = AnyView(ReviewView())
        vc.bottomVC.photoVC.hc.rootView = AnyView(ReviewView())
        vc.bottomVC.aboutVC.hc.rootView = AnyView(AboutView())
        
        vc.topVC.hc.rootView = AnyView(ServiceViewObjectsWrapper())
        return vc
    }
    
    func updateUIViewController(_ viewController: SplitViewController, context: Context) {
    }
}

struct SampleUIServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView(id: 18)
    }
}
