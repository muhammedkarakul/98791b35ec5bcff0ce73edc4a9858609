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
        viewModel.getStations()
        viewModel.configureHomeView(baseView)
    }
    
    // MARK: - Setup
    override func linkInteractor() {
        super.linkInteractor()
        viewModel.delegate = self
        baseView.setCollectionViewDelegate(self, andDataSource: self)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        title = "UGS: 00000  EUS: 00000 DS: 00000"
        tabBarItem = UITabBarItem(title: "İstasyon", image: .rocket, tag: 0)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StationCollectionViewCell
        viewModel.configureStationCollectionViewCell(cell, forIndexPath: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width, height: view.bounds.width)
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func didErrorOccured(_ error: Error?) {
        if let error = error {
            showError(message: error.localizedDescription)
        }
    }
    
    func didResponseFetched(_ response: [Station]?) {
        baseView.refresh()
    }
}
