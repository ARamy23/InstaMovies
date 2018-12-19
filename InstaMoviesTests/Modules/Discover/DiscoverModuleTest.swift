//
//  DiscoverModuleTest.swift
//  InstaMoviesTests
//
//  Created by Ahmed Ramy on 12/19/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import InstaMovies

class DiscoverTests: BaseModuleTest {
    var viewModel: DiscoverViewModel!
    
    override func setUp() {
        super.setUp()
        initialize()
    }
    
    func initialize() {
        viewModel = DiscoverViewModel(router: router, service: DiscoverService.self)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testShowingOfAlertWhenNoInternet() {
        // Given
        Reachability.testingValue = false
        
        // When
        viewModel.fetchMovies()
        
        // Then
        let expectedError = ValidationError.unreachable.localizedDescription
        // We executing a network call, the router has two actions after validating the reachability using our test value for the reachability class
        // first action is stopping the activity indicator
        // and the other is the error we are expecting which is unreachable error
        XCTAssertEqual(router.actions.count, 2)
        XCTAssertEqual(router.actions[1], .alert(expectedError))
        
        Reachability.testingValue = nil
    }
    
    func testNotShowingAlertWhenThereIsInternet() {
        // Given
        Reachability.testingValue = true
        
        // When
        viewModel.fetchMovies()
        
        // Then
        XCTAssertEqual(router.actions.count, 1)
        XCTAssertEqual(router.actions[0], .activityStop)
        Reachability.testingValue = nil
    }
    
    func testParsing() {
        // Given nothing
        
        //When
        viewModel.fetchMovies { (isSuccess, moviesCount) -> (Void) in
            // Then
            XCTAssertTrue(isSuccess)
            XCTAssertEqual(moviesCount, 20)
        }
    }
    
    func testPagination() {
        // Given nothing
        
        // When
        viewModel.fetchMovies { (isSuccess, moviesCount) -> (Void) in
            
            // Then
            XCTAssertTrue(isSuccess)
            XCTAssertEqual(moviesCount, 20)
        }
        viewModel.fetchMoreMovies { (isSuccess, moviesCount) -> (Void) in
            XCTAssertTrue(isSuccess)
            XCTAssertEqual(moviesCount, 40)
        }
    }
}
