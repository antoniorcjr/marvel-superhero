//
//  SuperHeroViewModel.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 02/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation

struct SuperHeroViewModel {
    // MARK: - Properties
    let superHeroData: SuperHeroData

    // MARK: - Computed properties
    var name: String {
        return superHeroData.name
    }

    var description: String {
        return superHeroData.descriptionText
    }

    var image: String {
        return superHeroData.imagePath
    }
}
