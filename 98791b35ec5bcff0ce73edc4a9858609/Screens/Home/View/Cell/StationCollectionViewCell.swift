//
//  StationCollectionViewCell.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import UIKit

final class StationCollectionViewCell: BaseCollectionViewCell {
    // MARK: Properties
    var capacity: String? {
        didSet {
            capacityLabel.text = capacity
        }
    }
    
    var universalSpaceTime: String? {
        didSet {
            universalSpaceTimeLabel.text = universalSpaceTime
        }
    }
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    // MARK: UI
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15.0
        view.layer.borderWidth = 1.0
        if #available(iOS 13.0, *) {
            view.layer.borderColor = UIColor.label.cgColor
        } else {
            view.layer.borderColor = UIColor.black.cgColor
        }
        return view
    }()
    
    private lazy var capacityLabel = UILabel()
    
    private lazy var universalSpaceTimeLabel = UILabel()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .title
        label.textAlignment = .center
        return label
    }()
    
    private lazy var addFavoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.star, for: .normal)
        return button
    }()
    
    private lazy var travelButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1.0
        if #available(iOS 13.0, *) {
            button.layer.borderColor = UIColor.label.cgColor
        } else {
            button.layer.borderColor = UIColor.black.cgColor
        }
        button.setTitle("Seyahat Et", for: .normal)
        return button
    }()
    
    // MARK: Setup
    override func prepareLayout() {
        super.prepareLayout()
        
        setupContainerViewLayout()
        setupAddFavoriteButtonLayout()
        setupCapacityLabelLayout()
        setupUniversalSpaceTimeLabelLayout()
        setupNameLabelLayout()
        setupTravelButtonLayout()
    }
    
    // MARK: Methods
    private func setupContainerViewLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAddFavoriteButtonLayout() {
        containerView.addSubview(addFavoriteButton)
        addFavoriteButton.snp.makeConstraints { make in
            make.top.equalTo(16.0)
            make.trailing.equalTo(-16.0)
            make.width.height.equalTo(32.0)
        }
    }
    
    private func setupCapacityLabelLayout() {
        containerView.addSubview(capacityLabel)
        capacityLabel.snp.makeConstraints { make in
            make.leading.equalTo(16.0)
            make.top.equalTo(16.0)
            make.trailing.equalTo(addFavoriteButton.snp.leading).offset(-8.0)
            make.height.equalTo(32.0)
        }
    }
    
    private func setupUniversalSpaceTimeLabelLayout() {
        containerView.addSubview(universalSpaceTimeLabel)
        universalSpaceTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(16.0)
            make.top.equalTo(capacityLabel.snp.bottom).offset(8.0)
            make.trailing.equalTo(addFavoriteButton.snp.leading).offset(-8.0)
            make.height.equalTo(32.0)
        }
    }
    
    private func setupNameLabelLayout() {
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(16.0)
            make.top.equalTo(universalSpaceTimeLabel.snp.bottom).offset(16.0)
            make.trailing.equalTo(-16.0)
        }
    }
    
    private func setupTravelButtonLayout() {
        containerView.addSubview(travelButton)
        travelButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(240.0)
            make.height.equalTo(32.0)
            make.bottom.equalTo(-16.0)
        }
    }
}
