//
//  MainTabBarController.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    private lazy var homeNavigationController = UINavigationController(rootViewController: HomeViewController())
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [homeNavigationController]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}
