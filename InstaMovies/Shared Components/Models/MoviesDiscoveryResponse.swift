//
//  MoviesDiscoveryResponse.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

struct MoviesDiscoveryResponse: Codable, CodableInit {
    let page, totalResults, totalPages: Int?
    let movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct Movie: Codable, CodableInit {
    let title, posterPath, overview, releaseDate: String?
    
    init(title: String, image: UIImage?, overview: String?, releaseDate: String?) {
        self.title = title
        self.posterPath = nil
        self.overview = overview
        self.releaseDate = releaseDate
        self.image = image
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    
    // MARK: User Created Movie Properties
    var image: UIImage? = nil
}
