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
