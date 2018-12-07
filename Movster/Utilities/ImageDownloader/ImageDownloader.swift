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
    var ongoingDownloadQueue = [String: [(UIImage?) -> Void]]()
    
    // MARK: - Public Methods
    
    func downloadImage(imageURL: String, completion: @escaping (_ image: UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            completion(cachedImage)
        } else {
            queueUpBlockWithURL(imageURL: imageURL, imageExecutionBlock: completion)
        }
    }
    
    // MARK: - Private Methods
    
    private func queueUpBlockWithURL(imageURL: String, imageExecutionBlock: @escaping (UIImage?) -> Void) {
        if var blockArray = ongoingDownloadQueue[imageURL] {
            blockArray.append(imageExecutionBlock)
            ongoingDownloadQueue[imageURL] = blockArray
        } else {
            ongoingDownloadQueue[imageURL] = [imageExecutionBlock]
            guard let url = URL(string: imageURL) else { return }
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if error != nil {
                    print("error")
                }
                guard let data = data, let retrievedImage = UIImage(data: data) else { return }
                self?.imageCache.setObject(retrievedImage, forKey: url.absoluteString as NSString)
                self?.executeAllBlockGivenImageURL(imageURL: imageURL)
                }.resume()
        }
    }
    
    private func executeAllBlockGivenImageURL(imageURL: String) {
        if let blockArray = ongoingDownloadQueue[imageURL] {
            for block in blockArray {
                block(imageCache.object(forKey: imageURL as NSString))
            }
        }
    }
}

