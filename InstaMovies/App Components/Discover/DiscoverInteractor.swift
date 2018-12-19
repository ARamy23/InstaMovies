//
//  DiscoverInteractor.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

class DiscoverInteractor: BaseInteractor {
    
    var page: Int = 0
    
    init(_ page: Int) {
        super.init(service: DiscoverService.self)
        self.page = page
    }
    
    override func request(onComplete: @escaping (CodableInit?, Error?) -> Void) {
        super.request(onComplete: onComplete)
        
        guard let discoverService = service as? DiscoverService.Type else { return }
        
        discoverService.init(.discoverMovies(page: page)).send(MoviesDiscoveryResponse.self) { (response) in
            switch response {
            case .success(let value):
                onComplete(value, nil)
            case .failure(let error):
                onComplete(nil, error)
            }
        }
    }
}
