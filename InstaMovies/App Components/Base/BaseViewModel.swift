//
//  BaseViewModel.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/18/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

enum BaseViewState {
    case loading
    case failed
    case fetchedData
}

class BaseViewModel {
    var router: RouterProtocol
    
    var interactor: BaseInteractor
    var viewState: Dynamic<BaseViewState> = Dynamic(.loading) {
        didSet {
            switch viewState.value {
            case .loading?: router.startActivityIndicator()
            default: router.stopActivityIndicator()
            }
        }
    }
    
    init(router: RouterProtocol, service: BaseService.Type?) {
        self.router = router
        self.interactor = BaseInteractor(service: service)
    }
}
