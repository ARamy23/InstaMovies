//
//  BaseViewController.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var router = Router()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // add default willAppear Logic here
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add default viewDidLoad logic here
        router.presentedVC = self
        bind()
    }
    
    func bind() {}
    func initialize() {}
}
