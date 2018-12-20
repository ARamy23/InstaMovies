//
//  ImagesManager.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/20/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class ImagesManager {
    
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        self.cache = NSCache()
    }
    
    func getImage(from imagePath: String, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let placeholder = #imageLiteral(resourceName: "discover")
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            let url = URL(string: "https://image.tmdb.org/t/p/original")!.appendingPathComponent(imagePath)
            DispatchQueue.global(qos: .background).async {
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
