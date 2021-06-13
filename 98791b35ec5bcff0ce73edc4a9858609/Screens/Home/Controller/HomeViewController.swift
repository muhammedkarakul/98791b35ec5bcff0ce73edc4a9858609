//
//  HomeViewController.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    
    // MARK: - Properties
    private let viewModel = HomeViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configureHomeView(baseView)
    }
    
    // MARK: - Setup
    override func configureAppearance() {
        super.configureAppearance()
        title = "UGS: 00000  EUS: 00000 DS: 00000"
        tabBarItem = UITabBarItem(title: "İstasyon", image: UIImage(named: "rocket"), tag: 0)
    }
}
