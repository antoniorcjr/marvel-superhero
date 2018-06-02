//
//  SuperHeroTableViewCell.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 02/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit

class SuperHeroTableViewCell: UITableViewCell {
    // MARK: - Type properties
    static let cellReuseIdentifier = "SuperheroCell"

    // MARK: - Properties
    @IBOutlet weak var superheroImage: UIImageView!
    @IBOutlet weak var superheroName: UILabel!
    @IBOutlet weak var superheroDescription: UILabel!

    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    // MARK: - Cell configuration
    func configure(name: String, description: String) {
        superheroName.text = name
        superheroDescription.text = description
    }
}
