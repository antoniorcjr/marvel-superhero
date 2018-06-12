//
//  CollectionData.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 03/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation
import CoreData

public class CollectionData: NSManagedObject {
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

    @NSManaged var type: String
    @NSManaged var available: Int
    @NSManaged var collectionUri: String
    var items: [CollectionItem] = []

    public override init(entity: NSEntityDescription,
                         insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    init(dataDict: [String: Any], type: ParticipationType) {
        let context = CoreDataManager.shared.context
        let entity = NSEntityDescription.entity(forEntityName: "Collection", in: context)
        super.init(entity: entity!, insertInto: nil)

        self.type = type.rawValue
        available = (dataDict[Keys.available] as? Int) ?? 0
        collectionUri = (dataDict[Keys.collectionUri] as? String) ?? ""

        let itemsDict = (dataDict[Keys.items] as? [[String: Any]]) ?? []
        for item in itemsDict {
            items.append(CollectionItem(dataDict: item))
        }
    }
}

public class CollectionItem: NSManagedObject {
    public enum Keys {
        static let resourceUri = "resourceURI"
        static let name = "name"
    }

    @NSManaged var resourceUri: String
    @NSManaged var name: String

    init(dataDict: [String: Any]) {
        let context = CoreDataManager.shared.context
        let entity = NSEntityDescription.entity(forEntityName: "CollectionItem", in: context)
        super.init(entity: entity!, insertInto: nil)

        resourceUri = (dataDict[Keys.resourceUri] as? String) ?? ""
        name = (dataDict[Keys.name] as? String) ?? ""
    }
}

