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

    func getInTheaterMovies() {
        MovieDBNetworkSessions.getInTheatersNowMovieList { [weak self] (payload) in
            if payload.results.count > 0 {
                self?.movies = payload.results
                self?.delegate?.updateMovieData()
            }
        }
    }
}
