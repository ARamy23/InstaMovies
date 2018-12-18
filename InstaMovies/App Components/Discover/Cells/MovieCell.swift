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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // formula for cornerRadius dynamic height
        // when on iPhone 6 family, height = 667 -> 20
        // when any device's height, height -> X
        // Cross Multiplication
        // X = radius = 20 * screenHeight / 667
        // therefor aspect ratio = 20 / 667
        
        cellBodyView.setupDynamicCornerRadius(withAspectRatioOf: 20/667, accordingTo: UIScreen.main.bounds.height)
        
        // formula for borderWidth dynamic width
        // when on iPhone 6 family, height = 667 -> 4
        // when any device's height, height -> X
        // Cross Multiplication
        // X = radius = 4 * screenHeight / 667
        // therefor aspect ratio = 4 / 667
        
        cellBodyView.setupDynamicBorderWidth(withAspectRatioOf: 4 / 667, accordingTo: UIScreen.main.bounds.height)
        
        cellBodyView.applyDropShadow(color: .black, opacity: 0.25, offSet: CGSize(width: 0, height: 3), radius: 6, scale: true)
    }
}
