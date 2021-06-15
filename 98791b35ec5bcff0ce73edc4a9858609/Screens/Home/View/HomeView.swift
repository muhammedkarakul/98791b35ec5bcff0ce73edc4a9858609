//
//  HomeView.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import UIKit

final class HomeView: BaseView {
    
    // MARK: - Properties
    var spacecraftName: String? {
        didSet {
            nameLabel.text = spacecraftName
        }
    }
    
    var damageCapacity: Int64? {
        didSet {
            damageCapacityLabel.text = "\(damageCapacity ?? 0)"
        }
    }
    
    var time: Int64? {
        didSet {
            timeLabel.text = "\(time ?? 0)s"
        }
    }
    
    var stationName: String? {
        didSet {
            stationNameLabel.text = stationName
        }
    }
    
    // MARK: - UI
    private lazy var nameLabel = UILabel()
    
    private lazy var damageCapacityLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 1.0
        if #available(iOS 13.0, *) {
            label.layer.borderColor = UIColor.label.cgColor
        } else {
            label.layer.borderColor = UIColor.black.cgColor
        }
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 1.0
        if #available(iOS 13.0, *) {
            label.layer.borderColor = UIColor.label.cgColor
        } else {
            label.layer.borderColor = UIColor.black.cgColor
        }
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, damageCapacityLabel, timeLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16.0
        return stackView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Ara"
        return searchBar
    }()
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var stationNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .title
        return label
    }()
    
    // MARK: - Setup
    override func linkInteractor() {
        super.linkInteractor()
        collectionView.register(StationCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        setupStackViewLayout()
        setupSearchBarLayout()
        setupCollectionViewLayout()
        setupCurrentStationNameLabelLayout()
    }
    
    // MARK: - Methods
    private func setupStackViewLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(16.0)
            if #available(iOS 11.0, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32.0)
            } else {
                make.top.equalTo(76.0)
            }
            make.trailing.equalTo(-16.0)
            make.height.equalTo(32.0)
        }
    }
    
    private func setupSearchBarLayout() {
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(16.0)
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupCollectionViewLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(16.0)
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupCurrentStationNameLabelLayout() {
        addSubview(stationNameLabel)
        stationNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(16.0)
            make.top.equalTo(collectionView.snp.bottom).offset(32.0)
            make.trailing.equalTo(-16.0)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-32.0)
            } else {
                make.bottom.equalTo(-115.0)
            }
        }
    }
    
    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate, andDataSource dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func indexPathForCell(_ cell: UICollectionViewCell) -> IndexPath? {
        collectionView.indexPath(for: cell)
    }
}
