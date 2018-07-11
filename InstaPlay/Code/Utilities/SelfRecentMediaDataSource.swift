//
//  SelfRecentMediaDataSource.swift
//  InstaPlay
//
//  Created by Vincent Douant on 11/07/2018.
//  Copyright © 2018 Vincent Douant. All rights reserved.
//

import InstagramKit

class SelfRecentMediaDataSource : NSObject, UICollectionViewDataSource {
    var items = [InstagramMedia]()

    func append(medias: [InstagramMedia], collectionView: UICollectionView) {
        guard medias.count > 0 else { return }
        collectionView.performBatchUpdates({
            let startIndex = items.count
            items += medias
            var indexPaths = [IndexPath]()
            for index in startIndex..<(startIndex + medias.count) {
                indexPaths.append(IndexPath(row: index, section: 0))
            }
            collectionView.insertItems(at: indexPaths)
        }, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func getInstagramMedia(at indexPath: IndexPath) -> InstagramMedia? {
        return items[indexPath.row]
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailCollectionViewCell", for: indexPath)
        if let cell = cell as? ThumbnailCollectionViewCell, let item = getInstagramMedia(at: indexPath) {
            cell.configureCell(with: item.thumbnailURL)
        }
        return cell
    }
}
