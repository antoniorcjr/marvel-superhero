//
//  SuperHeroData.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 02/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation


struct SuperHeroData {
    private enum Keys {
        static let id = "id"
        static let name = "name"
        static let description = "description"
        static let thumbnail = "thumbnail"
        static let path = "path"
        static let extensionPath = "extension"
        static let comics = "comics"
        static let series = "series"
        static let stories = "stories"
        static let events = "events"
    }

    // MARK: - Properties
    let id: Int
    let name: String
    let descriptionText: String
    let imagePath: String

    // MARK: -
    var asDictionary: [String: Any] {
        return [ Keys.id: id,
                 Keys.name : name,
                 Keys.description: descriptionText,
                 Keys.path: imagePath ]
    }
}

extension SuperHeroData {
    // MARK: - Initialization
    init?(dictionary: [String: Any]) {
        id = (dictionary[Keys.id] as? Int) ?? 0
        name = (dictionary[Keys.name] as? String) ?? ""
        descriptionText = (dictionary[Keys.description] as? String) ?? ""
        imagePath = (dictionary[Keys.path] as? String) ?? ""
    }
}
