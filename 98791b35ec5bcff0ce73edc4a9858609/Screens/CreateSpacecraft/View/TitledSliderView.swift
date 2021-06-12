//
//  TitledSliderView.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit

final class TitledSliderView: BaseView {
    // MARK: Properties
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    var sliderValue: Float? {
        slider.value
    }
    
    // MARK: - UI
    private lazy var label = UILabel()
    private lazy var slider = UISlider()
    
    // MARK: - Setup
    override func prepareLayout() {
        super.prepareLayout()
        setupLabelLayout()
        setupSliderLayout()
    }
    
    // MARK: - Methods
    private func setupLabelLayout() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupSliderLayout() {
        addSubview(slider)
        slider.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(8.0)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

