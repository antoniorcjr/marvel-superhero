//
//  SuperHeroData.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 02/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation
import CoreData

public class SuperHeroData: NSManagedObject {
   public struct Keys {
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
    @NSManaged public var id: Int
    @NSManaged public var name: String
    @NSManaged public var descriptionText: String
    @NSManaged public var imagePath: String
    public var comics: CollectionData?
    public var series: CollectionData?
    public var stories: CollectionData?
    public var events: CollectionData?

    public override init(entity: NSEntityDescription,
                         insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    // MARK: - Initialization
    init(dictionary: [String: Any]) {
        let context = CoreDataManager.shared.context
        let entity = NSEntityDescription.entity(forEntityName: "SuperHero", in: context)
        super.init(entity: entity!, insertInto: nil)

        id = (dictionary[Keys.id] as? Int) ?? 0
        name = (dictionary[Keys.name] as? String) ?? ""
        descriptionText = (dictionary[Keys.description] as? String) ?? ""

        let thumbnailData = (dictionary[Keys.thumbnail] as? [String: Any]) ?? [:]
        let path = (thumbnailData[Keys.path] as? String) ?? ""
        let extensionPath = (thumbnailData[Keys.extensionPath] as? String) ?? ""
        self.imagePath = path + "." + extensionPath

        // Creating the Comic, Series, Stories and Events list
        let comicData = (dictionary[Keys.comics] as? [String: Any]) ?? [:]
        self.comics = CollectionData(dataDict: comicData, type: .comics)
        let seriesData = (dictionary[Keys.series] as? [String: Any]) ?? [:]
        self.series = CollectionData(dataDict: seriesData, type: .series)
        let storiesData = (dictionary[Keys.stories] as? [String: Any]) ?? [:]
        self.stories = CollectionData(dataDict: storiesData, type: .stories)
        let eventsData = (dictionary[Keys.events] as? [String: Any]) ?? [:]
        self.events = CollectionData(dataDict: eventsData, type: .events)
    }
}
