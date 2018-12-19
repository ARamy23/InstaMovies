//
//  BaseModuleTest.swift
//  InstaMoviesTests
//
//  Created by Ahmed Ramy on 12/19/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import InstaMovies

class BaseModuleTest: XCTestCase {
    
    var router: RouterMock!
    
    override func setUp() {
        router = RouterMock()
    }
}
