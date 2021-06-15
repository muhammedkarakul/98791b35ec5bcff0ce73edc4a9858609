//
//  MyFavoritesViewController.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 15.06.2021.
//

import UIKit

final class MyFavoritesViewController: BaseViewController<MyFavoritesView> {
    // MARK: - Properties
    var viewModel = MyFavoritesViewModel()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStations()
    }
    
    // MARK: - Setup
    override func linkInteractor() {
        super.linkInteractor()
        baseView.setTableViewDelegate(self, andDataSource: self)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        title = "Favoriler"
        tabBarItem = UITabBarItem(title: "Favoriler", image: .star, tag: 1)
    }
    
    // MARK: - Methods
    private func fetchStations() {
        viewModel.fetchStations { error in
            if let error = error {
                self.showError(message: error.localizedDescription)
                return
            }
            baseView.refresh()
        }
    }
}

// MARK: - UITableViewDelegate
extension MyFavoritesViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension MyFavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyFavoritesTableViewCell
        cell.delegate = self
        viewModel.configureMyFavoriteTableViewCell(cell, forIndexPath: indexPath)
        return cell
    }
}

// MARK: - MyFavoritesTableViewCellDelegate
extension MyFavoritesViewController: MyFavoritesTableViewCellDelegate {
    func myFavoritesTableViewCell(_ cell: MyFavoritesTableViewCell, didFavoriteButtonTapped button: UIButton) {
        guard let indexPath = baseView.indexPathForCell(cell) else { return }
        viewModel.addFavorite(forIndexPath: indexPath) { error in
            if let error = error {
                self.showError(message: error.localizedDescription)
                return
            }
            self.baseView.refresh()
        }
    }
}
