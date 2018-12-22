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
    
    var selectedIndexPath: IndexPath?
    
    var discoverViewModel: DiscoverViewModel!
    var addNewMovieViewModel: AddNewMovieViewModel!
    
    override func bind() {
        discoverViewModel = DiscoverViewModel(router: router, service: DiscoverService.self)
        addNewMovieViewModel = AddNewMovieViewModel(router: router, service: nil)
        discoverViewModel.allMovies.bind = { [unowned self] _ in self.discoveryFeedTableView.reloadData() }
        addNewMovieViewModel.usersMovies.bind = { [unowned self] _ in self.discoveryFeedTableView.reloadData() }
    }
    
    fileprivate func setupUI() {
        discoveryFeedTableView.dataSource = self
        discoveryFeedTableView.delegate = self
        discoveryFeedTableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.reuseIdentifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNewMovie))
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAllMovies), for: .valueChanged)
        discoveryFeedTableView.refreshControl = refreshControl
    }
    
    override func initialize() {
        super.initialize()
        setupUI()
        discoverViewModel.fetchMovies()
        discoverViewModel.router = self.router
        addNewMovieViewModel.router = self.router
    }
    
    @objc fileprivate func refreshAllMovies() {
        discoverViewModel.fetchMovies()
    }
    
    @objc fileprivate func addNewMovie() {
        let addNewMovieVC = AddNewMovieViewController()
        addNewMovieVC.viewModel = addNewMovieViewModel
        present(addNewMovieVC, animated: true, completion: nil)
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
            return addNewMovieViewModel.usersMovies.value?.count ?? 0
        case 1:
            return discoverViewModel.allMovies.value?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let movie = (indexPath.section == 1) ? discoverViewModel.allMovies.value?[indexPath.row] : addNewMovieViewModel.usersMovies.value?[indexPath.row]
        cell.movie = movie
        // if it's a user's movie and it has an image, use that image
        if let userMovieImage = movie?.image {
            cell.posterImageView.image = userMovieImage
        }
        // else either get the image from the cache or download it
        else if let posterPath = movie?.posterPath {
            ImagesManager.shared.getImage(from: posterPath) { (moviePoster) in
                guard let cellToUpdate = tableView.cellForRow(at: indexPath) as? MovieCell else { return }
                cellToUpdate.posterImageView.image = moviePoster
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let movie = (indexPath.section == 1) ? discoverViewModel.allMovies.value?[indexPath.row] : addNewMovieViewModel.usersMovies.value?[indexPath.row]
        let collapsedHeight: CGFloat = 150
        let overviewCollapsedHeight: CGFloat = 47
        let overviewExpandedHeight: CGFloat = estimateOverviewSize(text: movie?.overview ?? "").height
        let expandedHeight: CGFloat = collapsedHeight - overviewCollapsedHeight + overviewExpandedHeight
        
        if selectedIndexPath != nil, selectedIndexPath! == indexPath {
            return expandedHeight
        } else {
            return collapsedHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectedIndexPath {
        case nil: selectedIndexPath = indexPath
        default:
            selectedIndexPath = (selectedIndexPath! == indexPath) ? nil : indexPath
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func estimateOverviewSize(text: String) -> CGRect
    {
        let size = CGSize(width: 375, height: 1000)
        return NSString(string: text).boundingRect(with: size,
                                                   options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin),
                                                   attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)],
                                                   context: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (maxOffset - offset) <= 0 {
            if (discoverViewModel.viewState.value == .fetchedData) {
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: discoveryFeedTableView.bounds.width, height: CGFloat(150))
                
                discoveryFeedTableView.tableFooterView = spinner
                discoveryFeedTableView.tableFooterView?.isHidden = false
                discoverViewModel.fetchMoreMovies()
            }
        }
    }
}
