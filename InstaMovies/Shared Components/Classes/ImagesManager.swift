//
//  ImagesManager.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/20/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class ImagesManager {
    
    static let shared = ImagesManager()
    
    private var cache: NSCache<NSString, UIImage> = NSCache()
    
    func getImage(from imagePath: String, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let placeholderImage = #imageLiteral(resourceName: "discover")
            DispatchQueue.main.async {
                completionHandler(placeholderImage)
            }
            let url = URL(string: "https://image.tmdb.org/t/p/original")!.appendingPathComponent(imagePath)
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let self = self else { return }
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            }
        }
    }
}
