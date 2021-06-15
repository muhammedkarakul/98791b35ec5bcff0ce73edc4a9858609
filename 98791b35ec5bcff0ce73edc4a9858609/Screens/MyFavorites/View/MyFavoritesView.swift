//
//  MyFavoritesView.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 15.06.2021.
//

import UIKit

final class MyFavoritesView: BaseView {
    // MARK: - UI
    private lazy var tableView = UITableView()
    
    // MARK: - Setup
    override func linkInteractor() {
        super.linkInteractor()
        tableView.register(MyFavoritesTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    func setTableViewDelegate(_ delegate: UITableViewDelegate, andDataSource dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func refresh() {
        tableView.reloadData()
    }
    
    func indexPathForCell(_ cell: UITableViewCell) -> IndexPath? {
        tableView.indexPath(for: cell)
    }
}
