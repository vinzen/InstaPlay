//
//  TabBar.swift
//  InstaPlay
//
//  Created by Vincent Douant on 11/07/2018.
//  Copyright © 2018 Vincent Douant. All rights reserved.
//

import UIKit

class TabBar : UITabBar {
    fileprivate static let selectedTag = 2935732
    fileprivate static let middleTag = 55732
    fileprivate static let numberOfItems: CGFloat = 5
    fileprivate static let middleItemIndex = 2
    fileprivate lazy var selectedView: UIView = {
        let view = UIView(frame: CGRect.null)
        view.backgroundColor = UIColor.black
        view.tag = TabBar.selectedTag
        return view
    }()
    fileprivate lazy var middleView: UIView = {
        let view = UIView(frame: CGRect.null)
        view.backgroundColor = UIColor(rgb: 0x125688)
        view.tag = TabBar.middleTag
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupExtraViews()
    }

    fileprivate func setupExtraViews() {
        selectedView.frame = extraViewFrame(0, availableWidth: UIScreen.main.bounds.width)
        addSubview(selectedView)
        middleView.frame = extraViewFrame(TabBar.middleItemIndex, availableWidth: UIScreen.main.bounds.width)
        addSubview(middleView)
        sendSubview(toBack: middleView)
        sendSubview(toBack: selectedView)
    }

    fileprivate func extraViewFrame(_ selectedTabItemIndex: Int, sizePercent: CGFloat = 1.0, availableWidth: CGFloat = 0) -> CGRect {
        var tabBarHeight = frame.size.height
        if #available(iOS 11.0, *) {
            tabBarHeight -= safeAreaInsets.bottom
        }
        let availableWidth = availableWidth == 0 ? frame.size.width : availableWidth
        let itemWidth = availableWidth / TabBar.numberOfItems
        let size = CGSize(width: itemWidth * sizePercent, height: tabBarHeight * sizePercent)
        let x = (itemWidth - size.width) / 2 + (CGFloat(selectedTabItemIndex) * itemWidth)
        let y = (tabBarHeight - size.height) / 2
        return CGRect(origin: CGPoint(x: x, y: y), size: size)
    }

    func highlightItem(selectedIndex: Int) {
        UIView.beginAnimations("selectedView", context: nil)
        selectedView.frame = extraViewFrame(selectedIndex)
        UIView.commitAnimations()
    }

    func updateExtraViews(_ selectedTabItemIndex: Int, availableWidth: CGFloat = 0) {
        selectedView.frame = extraViewFrame(selectedTabItemIndex, availableWidth: availableWidth)
    }
}
