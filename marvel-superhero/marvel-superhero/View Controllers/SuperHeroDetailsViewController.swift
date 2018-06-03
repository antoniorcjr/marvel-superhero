//
//  SuperHeroDetailsViewController.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 03/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit

class SuperHeroDetailsViewController: UIViewController {
    // MARK: - Properties
    var comicSegue = "ComicSegue"

    @IBOutlet weak var superHeroImage: UIImageView!
    @IBOutlet weak var superHeroName: UILabel!

    @IBOutlet weak var comicViewController: UIView!
    
    var viewModel: SuperHeroViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let viewModel = viewModel {
            superHeroImage.loadImage(fromURL: viewModel.image)
            superHeroName.text = viewModel.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
