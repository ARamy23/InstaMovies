//
//  BaseInteractor.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

class BaseInteractor {
    var service: BaseService.Type?
    
    init(service: BaseService.Type?) {
        self.service = service
    }
    
    func toValidate() throws {
        try ToSeeIfIsReachable().orThrow()
    }
    
    func request(onComplete: @escaping (CodableInit?, Error?) -> Void) {}
    
    func performARequest(onComplete: @escaping (CodableInit?, Error?) -> Void) {
        do {
            try toValidate()
            request(onComplete: onComplete)
        } catch let error {
            onComplete(nil, error)
        }
    }
}
