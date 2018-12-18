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
    
    var viewModel: DiscoverViewModel!
    
    override func bind() {
        viewModel = DiscoverViewModel(router: router, service: DiscoverService.self)
        viewModel.allMovies.bind = { [unowned self] _ in self.discoveryFeedTableView.reloadData() }
        viewModel.usersMovies.bind = { [unowned self] _ in self.discoveryFeedTableView.reloadData() }
    }
    
    fileprivate func setupUI() {
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
            return viewModel.usersMovies.value?.count ?? 0
        case 1:
            return viewModel.allMovies.value?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        let movie = (indexPath.section == 1) ? viewModel.allMovies.value?[indexPath.row] : viewModel.usersMovies.value?[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
}
