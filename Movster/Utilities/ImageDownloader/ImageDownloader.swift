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
}
