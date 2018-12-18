//
//  MovieCell.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var cellBodyView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverViewLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            posterImageView.downloadImage(from: movie?.posterPath)
            movieTitleLabel.text = movie?.title
            movieOverViewLabel.text = movie?.overview
            movieReleaseDateLabel.text = movie?.releaseDate
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = #imageLiteral(resourceName: "discover")
    }
}
