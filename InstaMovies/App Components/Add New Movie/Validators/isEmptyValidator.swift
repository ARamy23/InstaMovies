//
//  isEmptyValidator.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

class ToSeeIfIsNotEmpty: BaseValidator {
    var value: Any?
    var key: String
    
    init(value: Any?, key: String) {
        self.value = value
        self.key = key
    }
    
    func orThrow() throws {
        switch value {
        case "" as String:
            throw ValidationError.emptyValue(key: key)
        case nil:
            throw ValidationError.emptyValue(key: key)
        default: break
        }
    }
}
