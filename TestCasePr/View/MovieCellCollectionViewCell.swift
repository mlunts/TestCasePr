//
//  MovieCellCollectionViewCell.swift
//  TestCasePr
//
//  Created by Marina Lunts on 6/14/19.
//  Copyright © 2019 Marina Lunts. All rights reserved.
//

import UIKit

class MovieCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateIconImage: UIImageView!
    
    public func noRating() {
        rateLabel.isHidden = true
        rateIconImage.isHidden = true
    }
}
