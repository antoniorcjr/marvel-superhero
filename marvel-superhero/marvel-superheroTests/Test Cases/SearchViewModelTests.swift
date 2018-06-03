//
//  SearchViewModelTests.swift
//  marvel-superheroTests
//
//  Created by Antonio de Carvalho Jr on 03/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import XCTest
@testable import marvel_superhero

class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!

    override func setUp() {
        super.setUp()

        // Getting the DataWrapper
        let data = loadStubFromBundle(withName: "character", extension: "json")
        do {
            let json = (try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])
            if let json = json {
                let dataWrapper = DataWrapper(dataDict: json)

                guard let result = dataWrapper.data["results"] as? [[String: Any]] else {
                    return
                }
                var superHero: [SuperHeroData] = []
                for heroes in result {
                    if let hero = SuperHeroData(dictionary: heroes) {
                        superHero.append(hero)
                    }
                }

                viewModel = SearchViewModel(superHeroes: superHero)
            }
        } catch {}
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_HeroName() {
        let model = viewModel.viewModel(for: 0)
        XCTAssertEqual(model.name, "3-D Man")
    }
}
