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
    let superHeroData: (String, String)

    // MARK: - Computed properties
    var name: String {
        return superHeroData.0
    }

    var description: String {
        return superHeroData.1
    }
}
