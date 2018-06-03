//
//  DataWrapper.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 02/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation

struct DataWrapper {
    private enum Keys {
        static let code = "code"
        static let status = "status"
        static let copyright = "copyright"
        static let attributionText = "attributionText"
        static let etag = "etag"
        static let data = "data"
    }

    // MARK: - Properties
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let etag: String
    var data: [String: Any]

    var asDictionary: [String: Any] {
        return [Keys.code: code,
                Keys.status: status,
                Keys.code: copyright,
                Keys.attributionText: attributionText,
                Keys.etag: etag]
    }
}

extension DataWrapper {
    init(dataDict: [String: Any]) {
        code = (dataDict[Keys.code] as? Int) ?? 0
        status = (dataDict[Keys.status] as? String) ?? ""
        copyright = (dataDict[Keys.copyright] as? String) ?? ""
        attributionText = (dataDict[Keys.attributionText] as? String) ?? ""
        etag = (dataDict[Keys.etag] as? String) ?? ""
        data = (dataDict[Keys.data] as? [String: Any]) ?? [:]
    }
}
