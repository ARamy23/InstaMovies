//
//  Router.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class Router: RouterProtocol {
    
    var presentedVC: BaseViewController!
    
    func present(vc: BaseViewController) {
        presentedVC.present(vc, animated: true, completion: nil)
    }
    
    func startActivityIndicator() { }
    
    func stopActivityIndicator() { }
    
    func dismiss() {
        presentedVC.dismiss(animated: true, completion: nil)
    }
    
    func pop() {
        presentedVC.navigationController?.popViewController(animated: true)
    }
    
    func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.map({UIAlertAction(title: $0.title, style: $0.style, handler: $0.handler)}).forEach({alert.addAction($0)})
        
        presentedVC.present(alert, animated: true)
    }
}
