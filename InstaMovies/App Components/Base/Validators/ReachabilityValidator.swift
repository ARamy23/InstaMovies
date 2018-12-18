//
//  ReachabilityValidator.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

class ToSeeIfIsReachable: BaseValidator {
    func orThrow() throws {
        guard !Reachability.isConnectedToNetwork() else { return }
        throw ValidationError.unreachable
    }
}
