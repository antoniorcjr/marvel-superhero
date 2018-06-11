//
//  ParticipationData.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 03/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation

struct ParticipationData {
    private enum Keys {
        static let id = "id"
        static let title = "title"
        static let description = "description"
        static let thumbnail = "thumbnail"
        static let path = "path"
        static let pathExtension = "extension"
    }

    let id: Int
    let title: String
    let description: String
    let imagePath: String

    init(dataDict: [String: Any]) {
        id = (dataDict[Keys.id] as? Int) ?? 0
        title = (dataDict[Keys.title] as? String) ?? ""
        description = (dataDict[Keys.description] as? String) ?? ""

        let thumbnailDict = (dataDict[Keys.thumbnail] as? [String: Any]) ?? [:]
        let path = (thumbnailDict[Keys.path] as? String) ?? ""
        let extensionPath = (thumbnailDict[Keys.pathExtension] as? String) ?? ""
        imagePath = path + "." + extensionPath
    }
}
