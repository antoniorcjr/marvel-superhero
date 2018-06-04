//
//  CustomCollectionViewCell.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 03/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!

    // Cell configuration
    func configure(data: Participation) {
        image.loadImage(fromURL: data.imagePath)
        name.text = data.title
    }
}
