//
//  MyFavoritesViewController.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 15.06.2021.
//

import UIKit

final class MyFavoritesViewController: BaseViewController<MyFavoritesView> {
    // MARK: - Setup
    
    override func configureAppearance() {
        super.configureAppearance()
        title = "Favoriler"
        tabBarItem = UITabBarItem(title: "Favoriler", image: .star, tag: 1)
    }
}
