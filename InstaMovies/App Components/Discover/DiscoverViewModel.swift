//
//  DiscoverViewModel.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

class DiscoverViewModel: BaseViewModel {
    var usersMovies: Dynamic<[Movie]> = Dynamic([])
    var allMovies: Dynamic<[Movie]> = Dynamic([])
    var totalPages: Dynamic<Int?> = Dynamic(0)
    var totalResults: Dynamic<Int?> = Dynamic(0)
    var page: Dynamic<Int> = Dynamic(1)
    func fetchMovies() {
        DiscoverInteractor(page.value ?? 1).performARequest { [weak self] (model, error) in
            guard let self = self else { return }
            
            guard error == nil else {
                print("we've got an error here!")
                print(error ?? "nil error value")
                self.router.alert(title: "Error", message: error?.localizedDescription ?? "Oops something went wrong!", actions: [("ok", .default, nil)])
                return
            }
            
            
            guard let discoveryMoviesResponses = model as? MoviesDiscoveryResponse,
                let movies = discoveryMoviesResponses.movies else {
                    print("Parsing probably failed")
                    self.router.alert(title: "Error", message: "Oops something went wrong!", actions: [("ok", .default, nil)])
                    self.viewState = .failed
                    return
            }
            
            self.viewState = .fetchedData
            self.allMovies = Dynamic<[Movie]>(movies)
            self.totalPages = Dynamic<Int?>(discoveryMoviesResponses.totalPages)
            self.totalResults = Dynamic<Int?>(discoveryMoviesResponses.totalResults)
        }
    }
}
