//
//  NibNameProtocol.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static var nib: UINib? {
        return UINib(nibName: self.nibName, bundle: nil)
    }
    
}

// we can extend this to fit more views but we are only going to use the ones we need in order to not violate the YAGNI princibles 
extension UITableViewCell: NibLoadableView { }
