//
//  ReusableView.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

protocol ReusableView where Self: UIView { }

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// we can extend this to fit more views but we are only going to use the ones we need in order to not violate the YAGNI princibles 
extension UITableViewCell: ReusableView { }
