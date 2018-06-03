//
//  SearchViewModel.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 02/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation

struct SearchViewModel {
    // Mark: - Temporary data
    var superHeroes: [SuperHeroData]

    // Mark: - Computed properties
    var sections: Int {
        return 1
    }

    var rows: Int {
        return superHeroes.count
    }

    // Mark: - Functions
    func viewModel(for index: Int) -> SuperHeroViewModel {
        return SuperHeroViewModel(superHeroData: superHeroes[index])
    }
}
