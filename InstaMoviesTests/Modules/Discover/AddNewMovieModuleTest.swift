//
//  AddNewMovieModuleTest.swift
//  InstaMoviesTests
//
//  Created by Ahmed Ramy on 12/19/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import InstaMovies

class AddNewMovieModuleTest: BaseModuleTest {
    var viewModel: AddNewMovieViewModel!
    
    override func setUp() {
        super.setUp()
        initialize()
    }
    
    func initialize() {
        viewModel = AddNewMovieViewModel(router: router, service: nil)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    // TODO: Write making a movie validations
}
