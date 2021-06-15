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
    
    var count: Int64 = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        count = viewModel.dsTimerInterval
        
        Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(update),
                             userInfo: nil,
                             repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStations()
        fetchSpacecraft()
        navigationItem.title = viewModel.configuredTitle
    }
    
    // MARK: - Setup
    override func linkInteractor() {
        super.linkInteractor()
        baseView.setSearchBarDelegate(self)
        baseView.setCollectionViewDelegate(self, andDataSource: self)
        addGameOverObserver()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        navigationItem.title = "UGS: 00000  EUS: 00000 DS: 00000"
        tabBarItem = UITabBarItem(title: "İstasyon", image: .rocket, tag: 0)
    }
    
    // MARK: - Methods
    private func addGameOverObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(gameOver),
                                               name: .gameOver,
                                               object: nil)
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
    
    func stationCollectionViewCell(_ cell: StationCollectionViewCell, didTravelButtonTapped button: UIButton) {
        guard let indexPath = baseView.indexPathForCell(cell) else { return }
        viewModel.setCurrent(forIndexPath: indexPath) { [unowned self] error in
            if let error = error {
                showError(message: error.localizedDescription)
                return
            }
            viewModel.configureHomeView(baseView)
            navigationItem.title = viewModel.configuredTitle
            baseView.refresh()
        }
    }
}

// MARK: - Actions
extension HomeViewController {
    @objc
    private func update() {
        if count > 0 {
            baseView.time = count
            count -= 1
        } else {
            viewModel.decreaseDamageCapacity() { [unowned self] error in
                if let error = error {
                    showError(message: error.localizedDescription)
                    return
                }
                viewModel.configureHomeView(baseView)
                count = viewModel.dsTimerInterval
            }
        }
    }
    
    @objc
    private func gameOver() {
        let defaultAction = UIAlertAction(title: "Tamam", style: .default) { [unowned self] _ in
            viewModel.resetAllCoreData() { error in
                if let error = error {
                    showError(message: error.localizedDescription)
                    return
                }
                viewModel.appDelegate?.createWindow()
            }
        }
        showAlert(title: "Oyun Bitti",
                  message: "Tebrikler oyunu tamamladın! Yeniden oynamak ister misin?",
                  prefferedStyle: .alert,
                  actions: defaultAction)
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            guard let indexPath = viewModel.indexPathForStationName(searchText) else { return }
            baseView.scrollToItemForIndexPath(indexPath)
        }
    }
}
