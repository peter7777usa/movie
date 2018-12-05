//
//  URLComponents.swift
//  Movster
//
//  Created by Fong, Peter on 12/5/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import Foundation

extension URLComponents {
    static func constructURLComponents(urlString: String, parameters: [String: String]) -> URLComponents? {
        let urlString = movieDBAPIURL + "movie/now_playing"
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        return urlComponents
    }
}
