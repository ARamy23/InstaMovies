//
//  MainTabBarController.swift
//  InstaMovies
//
//  Created by Ahmed Ramy on 12/16/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTabBarViewControllers()
    }
    
    // MARK:- Setups
    
    private func setupTabBarViewControllers() {
        let discoverVC = generateNavigationController(from: DiscoverViewController(), title: "Discover", icon: #imageLiteral(resourceName: "discover"))
        
        viewControllers = [discoverVC]
    }
    
    //MARK:- Helpers
    
    private func generateNavigationController(from rootViewController: UIViewController, title: String, icon: UIImage) -> UINavigationController {
        let vc = UINavigationController(rootViewController: rootViewController)
        
        vc.tabBarItem.title = title
        vc.tabBarItem.image = icon
        vc.navigationController?.title = title
        vc.navigationBar.barTintColor = #colorLiteral(red: 0.1133852825, green: 0.1135058776, blue: 0.1134039238, alpha: 1)
        vc.navigationBar.tintColor = .white
        return vc
    }
}
