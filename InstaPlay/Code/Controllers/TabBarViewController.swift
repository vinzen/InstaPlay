//
//  TabBarViewController.swift
//  InstaPlay
//
//  Created by Vincent Douant on 11/07/2018.
//  Copyright © 2018 Vincent Douant. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    override var selectedIndex: Int {
        didSet {
            if let tabBar = self.tabBar as? TabBar {
                tabBar.updateExtraViews(selectedIndex)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        (tabBar as! TabBar).highlightItem(selectedIndex: selectedIndex)
    }
}
