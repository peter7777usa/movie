//
//  InTheaterNowModel.swift
//  Movster
//
//  Created by Fong, Peter on 12/5/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit

protocol InTheaterNowModelDelegate: AnyObject {
    func updateMovieData()
}

class InTheaterNowModel: NSObject {
    weak var delegate: InTheaterNowModelDelegate?
    var movies = [Movie]()
    var genreMapping = [String: String]()
    
    func getInTheaterMovies() {
        MovieDBNetworkSessions.getInTheatersNowMovieList { (payload) in
            if payload.results.count > 0 {
                self.movies = payload.results
                self.delegate?.updateMovieData()
            }
        }
    }
    
    func getMoviesGenres() {
        MovieDBNetworkSessions.getMoviesGenres { (payload) in
            
        }
    }
}
