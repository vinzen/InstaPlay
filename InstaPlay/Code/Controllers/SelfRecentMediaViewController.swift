//
//  SelfRecentMediaViewController.swift
//  InstaPlay
//
//  Created by Vincent Douant on 11/07/2018.
//  Copyright © 2018 Vincent Douant. All rights reserved.
//

import UIKit
import InstagramKit

class SelfRecentMediaViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    fileprivate var edgeInsets: UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    fileprivate var minimumInteritemSpacing: CGFloat {
        return 1
    }
    fileprivate var minimumLineSpacing: CGFloat {
        return 1
    }
    fileprivate var itemSize: CGSize {
        let edgeInsets = self.edgeInsets
        let edgeInset = edgeInsets.left + edgeInsets.right
        let availableWidth = collectionView!.frame.width - edgeInset - minimumInteritemSpacing * (numberOfItemPerRow - 1)
        let widthPerItem = availableWidth / numberOfItemPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    fileprivate var numberOfItemPerRow: CGFloat {
        return 3
    }
    fileprivate let dataSource = SelfRecentMediaDataSource()
    fileprivate var paginationInfo: InstagramPaginationInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = dataSource
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dataSource.items.count == 0 {
            fetchData()
        }
    }

    private func fetchData() {
        // 19 to test pagination
        InstagramEngine.shared().getSelfRecentMedia(withCount: 19, maxId: nil, success: { [weak self] (medias, paginationInfo) in
            self?.paginationInfo = paginationInfo
            self?.dataSource.items = medias
            self?.collectionView?.reloadData()
        }) { (error, code) in

        }
    }

    private func fetchMoreData() {
        guard let paginationInfo = paginationInfo, let collectionView = collectionView else { return }
        InstagramEngine.shared().getSelfRecentMedia(withCount: 20, maxId: paginationInfo.nextMaxId, success: { [weak self] (medias, paginationInfo) in
            self?.paginationInfo = paginationInfo
            DispatchQueue.main.async {
                self?.dataSource.append(medias: medias, collectionView: collectionView)
            }
        }) { (error, code) in

        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == dataSource.items.count - 1 else { return }
        fetchMoreData()
    }
}
