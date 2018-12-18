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
            viewModel.allMovies.value = self.allMovies
            discoveryFeedTableView.reloadData()
        }
    }
    var usersMovies = [Movie]() {
        didSet {
            viewModel.usersMovies.value = self.usersMovies
            discoveryFeedTableView.reloadData()
        }
    }
    var page: Int = 1 {
        didSet {
            viewModel.page.value = self.page
        }
    }
    var totalPages: Int? {
        didSet {
            viewModel.totalPages.value = totalPages
        }
    }
    var totalResults: Int? {
        didSet {
            viewModel.totalResults.value = totalResults
        }
    }
    
    var viewModel: DiscoverViewModel!
    
    override func bind() {
        viewModel = DiscoverViewModel(router: router, service: DiscoverService.self)
        viewModel.allMovies.bind = { [unowned self] in self.allMovies = $0 }
        viewModel.usersMovies.bind = { [unowned self] in self.usersMovies = $0 }
        viewModel.page.bind = { [unowned self] in self.page = $0 }
        viewModel.totalPages.bind = { [unowned self] in self.totalPages = $0 }
        viewModel.totalResults.bind = { [unowned self] in self.totalResults = $0 }
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
        viewModel.fetchMovies()
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
