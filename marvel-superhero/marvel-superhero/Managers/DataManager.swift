//
//  DataManager.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 02/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation

public struct API {
    private init() { }
    static let APIKey = "d33d9217e03bae10228d670f831a6457"
    static let privateKey = "590b2015f5d43b260e962c4f9490bf0dc93a081f"
    static let baseURL = "https://gateway.marvel.com"
    
    enum Routes: String {
        // MARK: - Routes list
        case caracters = "/v1/public/characters"

        // MARK: - Computed properties
        var url: String? {
            // Generate the final URL appending the ts, hash and apikey
            if let timestamp = timestamp {
                return baseURL + self.rawValue + timestamp
            } else {
                return baseURL + self.rawValue
            }
        }

        var timestamp: String? {
            // Generate the timestamp
            let ts = String(Int64(Date.timeIntervalSinceReferenceDate * 1000))
            
            // Generate the hash according with the ts, privateKey and publicKey
            let hashString = ts + privateKey + APIKey
            let hash = hashString.md5
            
            // Generate the final URL appending the ts, hash and apikey
            let auth = "?ts=" + ts + "&apikey=" + APIKey + "&hash=" + hash
            return auth
        }
    }
}

final class DataManager {
    var requestManager: RequestManager = RequestManager()

    /*:
     
     */
    func superHeroData(limit: Int, offset: Int, query: String, completion: @escaping ([SuperHeroData]) -> Void) {
        guard var stringUrl = API.Routes.caracters.url else { return }
        stringUrl += "&limit=" + String(limit)
        stringUrl += "&offset=" + String(offset)
        
        if query != "" {
            stringUrl += "&nameStartsWith=" + query
        }
        
        guard let url = URL(string: stringUrl) else { return }
        
        requestManager.request(url: url, method: .get) { (data, error) in
            guard let result = data["results"] as? [[String: Any]] else {
                completion([])
                return
            }
            var superHero: [SuperHeroData] = []
            for heroes in result {
                if let hero = SuperHeroData(dictionary: heroes) {
                    superHero.append(hero)
                }
            }
            completion(superHero)
        }
    }
}
