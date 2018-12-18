//
//  UIView+UIActivityIndicator.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

extension UIView {
    
    func activityStartAnimating(activityColor: UIColor = .white, alpha: CGFloat = 0.5) {
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.tag = 475647
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 250, height: 250))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(alpha)
        activityIndicator.layer.cornerRadius = 30
        self.isUserInteractionEnabled = false
        
        self.addSubview(activityIndicator)
        
        self.alpha = alpha
        
    }
    
    func activityStopAnimating() {
        if let activityIndicator = viewWithTag(475647){
            activityIndicator.removeFromSuperview()
        }
        
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }
}
