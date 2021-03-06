//
//  DiscoverViewModel.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

class DiscoverViewModel: BaseViewModel {
    var allMovies: Dynamic<[Movie]> = Dynamic([])
    var totalPages: Dynamic<Int?> = Dynamic(0)
    var totalResults: Dynamic<Int?> = Dynamic(0)
    var page: Dynamic<Int> = Dynamic(1)
    
    func fetchMovies(hasFinished: @escaping (Bool, Int) -> (Void) = {_,_ in }) {
        DiscoverInteractor(page.value ?? 1).performARequest { [weak self] (model, error) in
            guard let self = self else { return }
            
            guard error == nil else {
                print("we've got an error here!")
                print(error ?? "nil error value")
                self.viewState = Dynamic<BaseViewState>(.failed)
                self.router.alert(title: "Error", message: error?.localizedDescription ?? "Oops something went wrong!", actions: [("ok", .default, nil)])
                hasFinished(false, 0)
                return
            }
            
            guard let discoveryMoviesResponses = model as? MoviesDiscoveryResponse,
                let movies = discoveryMoviesResponses.movies else {
                    print("Parsing probably failed")
                    self.router.alert(title: "Error", message: "Oops something went wrong!", actions: [("ok", .default, nil)])
                    self.viewState = Dynamic<BaseViewState>(.failed)
                    hasFinished(false, 0)
                    return
            }
            
            self.viewState.value = .fetchedData
            self.allMovies.value = movies
            self.totalPages.value = discoveryMoviesResponses.totalPages
            self.totalResults.value = discoveryMoviesResponses.totalResults
            hasFinished(true, movies.count)
        }
    }
    
    func fetchMoreMovies(hasFinished: @escaping (Bool, Int?) -> (Void) = {_,_ in }) {
        
        page = Dynamic(page.value! + 1)
        DiscoverInteractor(page.value ?? 1).performARequest { [weak self] (model, error) in
            guard let self = self else { return }
            
            guard error == nil else {
                print("we've got an error here!")
                print(error ?? "nil error value")
                self.viewState = Dynamic<BaseViewState>(.failed)
                self.router.alert(title: "Error", message: error?.localizedDescription ?? "Oops something went wrong!", actions: [("ok", .default, nil)])
                hasFinished(false, nil)
                return
            }
            
            
            guard let discoveryMoviesResponses = model as? MoviesDiscoveryResponse,
                let movies = discoveryMoviesResponses.movies else {
                    print("Parsing probably failed")
                    self.router.alert(title: "Error", message: "Oops something went wrong!", actions: [("ok", .default, nil)])
                    self.viewState = Dynamic<BaseViewState>(.failed)
                    hasFinished(false, nil)
                    return
            }
            
            self.viewState.value = .fetchedData
            self.allMovies.value?.append(contentsOf: movies)
            hasFinished(true, self.allMovies.value?.count ?? 0)
        }
    }
}
