//
//  AddNewMovieInteractor.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class AddNewMovieInteractor: BaseInteractor {
    var title: String?
    var overview: String?
    var date: String?
    var posterImage: UIImage?
    
    init(_ title: String, overview: String?, date: String, posterImage: UIImage?) {
        super.init(service: nil)
        self.title = title
        self.overview = overview
        self.date = date
        self.posterImage = posterImage
    }
    
    override func toValidate() throws {
        try ToSeeIfIsNotEmpty(value: title, key: Keys.movieTitle).orThrow()
    }
    
    override func request(onComplete: @escaping (CodableInit?, Error?) -> Void) {
        super.request(onComplete: onComplete)
        
        let movie = Movie(title: title ?? "", image: posterImage, overview: overview, releaseDate: date)
        onComplete(movie, nil)
    }
    
    /// this is just a wrapper around performARequest in order to maintain code readability
    func save(onComplete: @escaping (CodableInit?, Error?) -> Void) {
        performARequest(onComplete: onComplete)
    }
}
