//
//  UIView.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

extension UIView {
    
    func round(corners: UIRectCorner = .allCorners, withRadiusOf radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addBorders(ofWidth width: CGFloat, color: UIColor = UIColor.white) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func setupDynamicCornerRadius(withAspectRatioOf aspectRatio: CGFloat, accordingTo metric: CGFloat) {
        let cornerRadius = metric * aspectRatio
        self.round(withRadiusOf: cornerRadius)
    }
    
    func setupDynamicBorderWidth(withAspectRatioOf aspectRatio: CGFloat, accordingTo metric: CGFloat, color: UIColor = .white) {
        let borderWidth = metric * aspectRatio
        self.addBorders(ofWidth: borderWidth)
    }
    
    func applyDropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func applyDropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
