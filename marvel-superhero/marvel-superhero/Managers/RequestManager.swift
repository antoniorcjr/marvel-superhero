//
//  RequestManager.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 02/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation

class RequestManager {
    let session = URLSession.shared
    var responseHeader: DataWrapper?

    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }

    public func request(url: URL, method: HttpMethod, completion: @escaping ([String: Any], Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { (data, response, error) in
            var json: [String: Any]?
            do {
                guard let data = data else { return }
                json = (try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])
                guard let json = json else { return }
                self.responseHeader = DataWrapper(dataDict: json)
                completion(self.responseHeader?.data ?? [:], nil)
            } catch {
                completion([:], "Cannot convert json" as? Error)
            }
        }.resume()
    }
}
