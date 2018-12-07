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
    let imageCache = NSCache<NSString, UIImage>()
    
    func downloadImage(imageURL: String, completion: @escaping (_ image: UIImage?) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if error != nil {
                    print("error")
                }
                guard let data = data, let retrievedImage = UIImage(data: data) else { return }
                self?.imageCache.setObject(retrievedImage, forKey: url.absoluteString as NSString)
                completion(retrievedImage)
                }.resume()
        }
    }
}
