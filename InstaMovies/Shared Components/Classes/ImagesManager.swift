//
//  ImagesManager.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/20/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

typealias ImageCacheLoaderCompletionHandler = ((UIImage) -> ())

class ImagesManager {
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    func getImage(from imagePath: String, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let placeholder = #imageLiteral(resourceName: "discover")
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            let url = URL(string: imagePath)!
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            })
            task.resume()
        }
    }
}
