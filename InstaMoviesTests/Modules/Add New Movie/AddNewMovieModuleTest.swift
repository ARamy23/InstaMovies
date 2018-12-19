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
    
    func testEnteringEmptyTitleShouldShowAlert() {
        // Given
        viewModel.movieTitle = Dynamic("")
        
        // When
        viewModel.saveMovie { (isSuccess) in
            // Then
            XCTAssertFalse(isSuccess)
            let expectedError = ValidationError.emptyValue(key: Keys.movieTitle).localizedDescription
            XCTAssertEqual(self.router.actions.count, 1)
            XCTAssertEqual(self.router.actions[0], .alert(expectedError))
        }
    }
    
    func testEnteringTitleShouldDismissView() {
        // Given
        viewModel.movieTitle = Dynamic("Avengers: The End Game")
        
        // When
        viewModel.saveMovie { (isSuccess) in
            // Then
            XCTAssertTrue(isSuccess)
            XCTAssertEqual(self.router.actions.count, 1)
            XCTAssertEqual(self.router.actions[0], .dismiss)
            XCTAssertGreaterThan(self.viewModel.usersMovies.value?.count ?? 0, 0)
        }
    }
}
