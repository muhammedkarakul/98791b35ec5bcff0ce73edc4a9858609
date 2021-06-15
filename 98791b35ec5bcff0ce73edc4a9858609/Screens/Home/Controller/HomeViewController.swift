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
        fetchStations()
        fetchSpacecraft()
    }
    
    // MARK: - Setup
    override func linkInteractor() {
        super.linkInteractor()
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
        cell.delegate = self
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

// MARK: - Service
extension HomeViewController {
    private func fetchStations() {
        viewModel.fetchStations { error in
            if let error = error {
                self.showError(message: error.localizedDescription)
                return
            }
            self.baseView.refresh()
        }
    }
    
    private func fetchSpacecraft() {
        viewModel.fetchSpacecraft { error in
            if let error = error {
                self.showError(message: error.localizedDescription)
                return
            }
            viewModel.configureHomeView(baseView)
        }
    }
}

// MARK: - StationCollectionViewCellDelegate
extension HomeViewController: StationCollectionViewCellDelegate {
    func stationCollectionViewCell(_ cell: StationCollectionViewCell, didFavoriteButtonTapped button: UIButton) {
        guard let indexPath = baseView.indexPathForCell(cell) else { return }
        viewModel.addFavorite(forIndexPath: indexPath) { error in
            if let error = error {
                self.showError(message: error.localizedDescription)
                return
            }
            self.baseView.refresh()
        }
    }
    
    func didTravelButtonTapped(_ sender: UIButton) {
        print("TRAVEL BUTTON TAPPED")
    }
}
