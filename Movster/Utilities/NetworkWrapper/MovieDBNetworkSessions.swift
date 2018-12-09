//
//  MovieDBNetworkSessions.swift
//  Movster
//
//  Created by Fong, Peter on 12/4/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit

let movieDBAPIKey = "2f692141148ec0d7dd35e8b6b409e26d"
let movieDBAPIURL = "https://api.themoviedb.org/3/"
let movieDBImageDownloadBaseURL = "https://image.tmdb.org/t/p/w185"

class MovieDBNetworkSessions: NSObject {
    
    //MARK: getInTheatersNowMovieList
    
    static func getInTheatersNowMovieList(completion: @escaping (( _ payload: MovieDBPayLoad) -> Void)) {
        let urlString = movieDBAPIURL + "movie/now_playing"
        let parameters = ["api_key": movieDBAPIKey, "language": "en-US"]
        let urlComponents = URLComponents.constructURLComponents(urlString: urlString, parameters: parameters)
        
        guard let url = urlComponents?.url else { return }
        let request =  URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("error")
            }
            guard let data = data else { return }
            if let payload: MovieDBPayLoad =  JSONHelper.loadJson(data: data) {
                completion(payload)
            }
            }.resume()
    }
}
