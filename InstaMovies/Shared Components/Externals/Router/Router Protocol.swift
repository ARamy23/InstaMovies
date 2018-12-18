//
//  Router Protocol.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    var presentedView: BaseViewController! { set get }
    func present(view: BaseViewController)
    
    func startActivityIndicator()
    func stopActivityIndicator()
    func dismiss()
    func pop()
    func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)])
}
