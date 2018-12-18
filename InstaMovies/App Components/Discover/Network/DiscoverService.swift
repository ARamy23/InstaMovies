//
//  DiscoverService.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

enum DiscoverService: BaseService {
    
    // MARK:- Cases
    
    case discoverMovies(page: Int)
    
    // MARK:- Configuration
    
    var path: String {
        switch self {
        case .discoverMovies: return ServerPath.discover
        }
    }
    
    var parameters: Parameters? {
        var params = Parameters.init()
        
        switch self {
        case .discoverMovies(page: let page):
            params["api_key"] = Keys.apiKey
            params["page"] = page
        }
        
        return params
    }
    
    var method: HTTPMethod {
        switch self {
        case .discoverMovies: return .get
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    init(_ service: DiscoverService) {
        switch service {
        case .discoverMovies(page: let page):
            self = .discoverMovies(page: page)
        }
    }
    
}
