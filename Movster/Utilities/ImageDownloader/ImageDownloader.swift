//
//  ImageDownloader.swift
//  Movster
//
//  Created by Fong, Peter on 12/6/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit

class ImageDownloader: NSObject {
    static let sharedInstance = ImageDownloader()

    func downloadImage(imageURL: String, completion: @escaping (_ image: UIImage?) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("error")
            }
            guard let data = data else { return }
            completion(UIImage(data: data))
        }.resume()
    }
    
    static func getInTheatersNowMovieList(completion: @escaping ((_ payload: MovieDBPayLoad) -> Void)) {
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
    ///https://image.tmdb.org/t/p/w154/
