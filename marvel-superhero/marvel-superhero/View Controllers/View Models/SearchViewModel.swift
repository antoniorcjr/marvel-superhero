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
    var heroes_tmp = [("SpiderMan", "Spiderman"),
                      ("Iron man", "Iron man")]

    // Mark: - Computed properties
    var sections: Int {
        return 1
    }

    var rows: Int {
        return heroes_tmp.count
    }

    // Mark: - Functions
    func viewModel(for index: Int) -> SuperHeroViewModel {
        return SuperHeroViewModel(superHeroData: heroes_tmp[index])
    }
}
