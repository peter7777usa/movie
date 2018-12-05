//
//  Movie.swift
//  Movster
//
//  Created by Fong, Peter on 12/5/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import Foundation

class MovieDBPayLoad: Decodable {
    let page: Int
    let results: [Movie]
}

class Movie: Decodable {
    let movieID: Int
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String
    let originalLanguage: String
    let originalTitle: String
    let genereIDs: [Int]
    let backdropPath: String?
    let adult: Bool
    let overview: String
    let releaseData: String
    
    private enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case voteCount = "vote_count"
        case video = "video"
        case voteAverage = "vote_average"
        case title = "title"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genereIDs = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case releaseData = "release_date"
    }
    
    // MARK: - Init methods
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movieID = try container.decode(Int.self, forKey: .movieID)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.video = try container.decode(Bool.self, forKey: .video)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.title = try container.decode(String.self, forKey: .title)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.genereIDs = try container.decode([Int].self, forKey: .genereIDs)
        self.backdropPath = try container.decode(String?.self, forKey: .backdropPath)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseData = try container.decode(String.self, forKey: .releaseData)
    }
}
