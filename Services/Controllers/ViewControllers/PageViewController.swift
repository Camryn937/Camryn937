//
//  PageViewController.swift
//  Services
//
//  Created by Camryn Crowder on 1/5/21.
//  Copyright © 2021 Capsule. All rights reserved.
//

import UIKit

//MARK: - PageViewController Initiallizer
class PageViewController: UIPageViewController {
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) { super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
