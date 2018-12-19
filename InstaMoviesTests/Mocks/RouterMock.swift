//
//  RouterMock.swift
//  InstaMoviesTests
//
//  Created by Ahmed Ramy on 12/19/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import Foundation

import UIKit
@testable import InstaMovies

enum RoutingAction: Equatable {
    case present(_ vc: BaseViewController)
    case activityStart
    case activityStop
    case dismiss
    case pop
    case alert(_ message: String)
    
    static public func ==(lhs: RoutingAction, rhs: RoutingAction) -> Bool {
        switch (lhs, rhs) {
        case let (.present(a), .present(b)): return a == b
        case let (.alert(a), .alert(b)): return a == b
        case (.activityStart, .activityStart),
             (.activityStop, .activityStop),
             (.dismiss, .dismiss),
             (.pop, .pop):
            return true
        default:
            return false
        }
    }
}

class RouterMock: RouterProtocol {
    var presentedVC: BaseViewController!
    
    
    var actions: [RoutingAction] = []
    
    func present(vc: BaseViewController) {
        actions.append(.present(vc))
    }
    
    func startActivityIndicator() {
        actions.append(.activityStart)
    }
    
    func stopActivityIndicator() {
        actions.append(.activityStop)
    }
    
    func dismiss() {
        actions.append(.dismiss)
    }
    
    func pop() {
        actions.append(.pop)
    }
    
    func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?)]) {
        self.actions.append(.alert(message))
    }
}
