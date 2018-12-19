//
//  AddNewMovieViewModel.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class AddNewMovieViewModel: BaseViewModel {
    
    var usersMovies: Dynamic<[Movie]> = Dynamic([])
    var moviePoster: Dynamic<UIImage> = Dynamic(#imageLiteral(resourceName: "discover"))
    var movieTitle: Dynamic<String> = Dynamic("")
    var movieOverview: Dynamic<String> = Dynamic("")
    var date: Dynamic<String> = Dynamic("")
    
    func saveMovie(isSuccess: @escaping (Bool) -> Void = {_ in }) {
        AddNewMovieInteractor(movieTitle.value ?? "No Title Set", overview: movieOverview.value, date: date.value ?? "No Date", posterImage: moviePoster.value)
            .save { [weak self] (model, error) in
                guard let self = self else {
                    isSuccess(false)
                    return
                }
                
                guard error == nil else {
                    print(error!)
                    self.router.alert(title: "Error", message: error!.localizedDescription, actions: [(title: "Ok", style: .default, handler: nil)])
                    isSuccess(false)
                    return
                }
                
                guard let movie = model as? Movie else {
                    self.router.alert(title: "Error", message: "Oops, Something went wrong", actions: [(title: "Ok", style: .default, handler: nil)])
                    isSuccess(false)
                    return
                }
                
                self.usersMovies.value?.append(movie)
                self.router.dismiss()
                isSuccess(true)
        }
    }
}
