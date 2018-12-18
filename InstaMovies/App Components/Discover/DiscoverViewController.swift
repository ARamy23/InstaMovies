//
//  DiscoverViewController.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {
    
    @IBOutlet private weak var discoveryFeedTableView: UITableView!
    
    var allMovies = [Movie]() {
        didSet {
            discoveryFeedTableView.reloadData()
        }
    }
    var usersMovies = [Movie]() {
        didSet {
            discoveryFeedTableView.reloadData()
        }
    }
    var page: Int = 1
    var totalPages: Int?
    var totalResults: Int?
    
    fileprivate func fetchMovies() {
        performARequest(from: DiscoverService.self) { [weak self] (model, error) in
            
            guard let self = self else { return }
            
            guard error == nil else {
                print("We got an error here")
                print(error ?? "nil error value")
                self.router.alert(title: "Error", message: error?.localizedDescription ?? "Oops something went wrong!", actions: [("ok", .default, nil)])
                self.viewState = .failed
                return
            }
            
            guard let discoveryMoviesResponses = model as? MoviesDiscoveryResponse,
                let movies = discoveryMoviesResponses.movies else {
                    print("Parsing probably have failed")
                    self.router.alert(title: "Error", message: "Oops something went wrong!", actions: [("ok", .default, nil)])
                    self.viewState = .failed
                    return
            }
            
            self.viewState = .fetchedData
            self.allMovies = movies
            self.totalPages = discoveryMoviesResponses.totalPages
            self.totalResults = discoveryMoviesResponses.totalResults
        }
    }
    
    fileprivate func setupUI() {
        viewState = .loading
        discoveryFeedTableView.dataSource = self
        discoveryFeedTableView.delegate = self
        
        discoveryFeedTableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    override func initialize() {
        super.initialize()
        setupUI()
        fetchMovies()
    }
    
    override func request<T: BaseService>(from service: T.Type, onComplete: @escaping (CodableInit?, Error?) -> Void) {
        super.request(from: service, onComplete: onComplete)
        
        guard let discoverService = service as? DiscoverService.Type else { return }
        
        discoverService.init(.discoverMovies(page: page)).send(MoviesDiscoveryResponse.self) { (response) in
            switch response {
            case .success(let value):
                onComplete(value, nil)
            case .failure(let error):
                onComplete(nil, error)
            }
        }
    }
}

// MARK: - TableView Methods

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "My Movies"
        case 1:
            return "All Movies"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return usersMovies.count
        case 1:
            return allMovies.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        let movie = (indexPath.section == 1) ? allMovies[indexPath.row] : usersMovies[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
}
