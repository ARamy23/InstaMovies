//
//  MoviesDiscoveryResponse.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

struct MoviesDiscoveryResponse: Codable, CodableInit {
    let page, totalResults, totalPages: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct Result: Codable, CodableInit {
    let voteCount, id: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String
    let originalLanguage: OriginalLanguage
    let originalTitle: String
    let genreIDS: [Int]
    let backdropPath: String
    let adult: Bool
    let overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
}

enum OriginalLanguage: String, Codable, CodableInit {
    case en = "en"
    case fr = "fr"
    case ja = "ja"
}
