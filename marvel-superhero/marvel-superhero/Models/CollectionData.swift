//
//  CollectionData.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 03/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation

public class Collection {
    public enum ParticipationType: String {
        case comics = "Comics"
        case series = "Series"
        case stories = "Stories"
        case events = "Events"
        case none
    }

    private enum Keys {
        static let available = "available"
        static let collectionUri = "collectionURI"
        static let items = "items"
    }

    var type: String
    var available: Int
    var collectionUri: String
    var items: [CollectionItem] = []

    init(dataDict: [String: Any], type: ParticipationType) {
        self.type = type.rawValue
        available = (dataDict[Keys.available] as? Int) ?? 0
        collectionUri = (dataDict[Keys.collectionUri] as? String) ?? ""

        let itemsDict = (dataDict[Keys.items] as? [[String: Any]]) ?? []
        for item in itemsDict {
            items.append(CollectionItem(dataDict: item))
        }
    }
}

public class CollectionItem {
    public enum Keys {
        static let resourceUri = "resourceURI"
        static let name = "name"
    }

    var resourceUri: String
    var name: String

    init(dataDict: [String: Any]) {
        resourceUri = (dataDict[Keys.resourceUri] as? String) ?? ""
        name = (dataDict[Keys.name] as? String) ?? ""
    }
}

