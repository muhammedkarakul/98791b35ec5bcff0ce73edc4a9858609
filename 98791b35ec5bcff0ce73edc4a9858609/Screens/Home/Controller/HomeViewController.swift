//
//  HomeViewController.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    
    // MARK: - Setup
    override func configureAppearance() {
        super.configureAppearance()
        navigationItem.setHidesBackButton(true, animated: true)
        tabBarItem = UITabBarItem(title: "İstasyon", image: UIImage(named: "rocket"), tag: 0)
    }
}