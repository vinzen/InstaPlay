//
//  ThumbnailCollectionViewCell.swift
//  InstaPlay
//
//  Created by Vincent Douant on 11/07/2018.
//  Copyright © 2018 Vincent Douant. All rights reserved.
//

import AlamofireImage

class ThumbnailCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.af_cancelImageRequest()
        imageView.layer.removeAllAnimations()
        imageView.image = nil
    }

    func configureCell(with URL: URL) {
        imageView.af_setImage(withURL: URL, imageTransition: .crossDissolve(0.2))
    }
}
