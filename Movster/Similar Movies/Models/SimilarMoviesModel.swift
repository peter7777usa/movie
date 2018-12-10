//
//  SimilarMoviesModel.swift
//  Movster
//
//  Created by Fong, Peter on 12/9/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import Foundation

protocol SimilarMoviesModelDelegate: AnyObject {
    func updateMoviesData()
}

class SimilarMoviesModel: NSObject {
    weak var delegate: SimilarMoviesModelDelegate?
    var movies = [Movie]()
    
    func getSimilarMovies() {
        MovieDBNetworkSessions.getSimilarMovies(movieID: "335983") { [weak self] (payload) in
            if payload.results.count > 0 {
                self?.movies = payload.results
                self?.delegate?.updateMoviesData()
            }
        }
    }
}
