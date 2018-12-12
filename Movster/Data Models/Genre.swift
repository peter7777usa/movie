//
//  Genre.swift
//  Movster
//
//  Created by Fong, Peter on 12/9/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import Foundation

class MovieDBGenresPayLoad: Decodable {
    let genres: [Genre]
}

class Genre: Decodable {
    let id: Int
    let name: String
}

class GenreMapping: NSObject {
    static let sharedInstance = GenreMapping()
    var mapping = [Int: String]()
    
    override init() {
        super.init()
        MovieDBNetworkSessions.getMoviesGenres { [weak self] (payload) in
            for genre in payload.genres {
                self?.mapping[genre.id] = genre.name
            }
        }
    }
}
