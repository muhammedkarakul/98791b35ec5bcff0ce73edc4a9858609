//
//  TitledSliderView.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit

protocol TitledSliderViewDelegate: AnyObject {
    func didSliderValueChanged(_ slider: UISlider)
}

final class TitledSliderView: BaseView {
    // MARK: Properties
    weak var delegate: TitledSliderViewDelegate?
    
    var title: String? {
        set {
            label.text = newValue
        }
        get {
            label.text
        }
    }
    
    var sliderValue: Float {
        set {
            slider.value = newValue
        }
        get  {
            slider.value
        }
    }
    
    // MARK: - UI
    private lazy var label = UILabel()
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 15
        slider.minimumValue = 0
        return slider
    }()
    
    convenience init(title: String?) {
        self.init()
        self.title = title
    }
    
    // MARK: - Setup
    override func linkInteractor() {
        super.linkInteractor()
        slider.addTarget(self, action: #selector(didSliderValueChanged(_:)), for: .valueChanged)
    }
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

// MARK: - Actions
extension TitledSliderView {
    @objc
    private func didSliderValueChanged(_ sender: UISlider) {
        delegate?.didSliderValueChanged(sender)
    }
}
