//
//  BaseViewController.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

enum BaseViewState {
    case loading
    case failed
    case fetchedData
}

class BaseViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var greyView: UIView = UIView(frame: .zero)
    
    var router = Router()
    
    var viewState: BaseViewState = .loading {
        didSet {
            switch viewState {
            case .loading: self.view.activityStartAnimating()
            default: self.view.activityStopAnimating()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // add default willAppear Logic here
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add default viewDidLoad logic here
        router.presentedVC = self
        initialize()
    }
    
    func initialize() {}
    
    func performARequest<T: BaseService>(from service: T.Type, onComplete: @escaping (CodableInit?, Error?) -> Void) {
        do {
            try toValidate()
            request(from: service, onComplete: onComplete)
        } catch let error {
            viewState = .failed
            router.alert(title: "Error", message: error.localizedDescription, actions: [("ok", .default, nil)])
        }
    }
    
    @objc func toValidate() throws {
        try ToSeeIfIsReachable().orThrow()
    }
    
    func request<T: BaseService>(from service: T.Type, onComplete: @escaping (CodableInit?, Error?) -> Void) {}
}
