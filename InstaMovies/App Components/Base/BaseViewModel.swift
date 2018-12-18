//
//  BaseViewModel.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

class BaseViewModel {
    var router: RouterProtocol
    
    var interactor: BaseInteractor
    var viewState: BaseViewState = .loading
    
    init(router: RouterProtocol, service: BaseService.Type) {
        self.router = router
        self.interactor = BaseInteractor(service: service)
    }
}
