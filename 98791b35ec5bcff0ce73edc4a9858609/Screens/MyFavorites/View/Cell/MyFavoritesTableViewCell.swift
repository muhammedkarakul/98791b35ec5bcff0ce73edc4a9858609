//
//  MyFavoritesTableViewCell.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 15.06.2021.
//

import UIKit

final class MyFavoritesTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    // MARK: - UI
    private lazy var titleLabel = UILabel()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .small
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.star, for: .normal)
        return button
    }()
    
    // MARK: - Setup
    override func prepareLayout() {
        super.prepareLayout()
        setupFavoriteButtonLayout()
        setupTitleLabelLayout()
        setupSubtitleLabelLayout()
    }
    
    // MARK: - Methods
    private func setupFavoriteButtonLayout() {
        contentView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(8.0)
            make.trailing.equalTo(-16.0)
            make.width.height.equalTo(32.0)
        }
    }
    
    private func setupTitleLabelLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(16.0)
            make.top.equalTo(8.0)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-8.0)
        }
    }
    
    private func setupSubtitleLabelLayout() {
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(16.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-8.0)
            make.bottom.equalTo(-16.0)
        }
    }
}
