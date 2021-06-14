//
//  CreateSpacecraftView.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit

protocol CreateSpacecraftViewDelegate: AnyObject {
    func didSumOfSliderValuesChanged(_ sender: UISlider, sumOfSliderValues sum: Float)
    func didContinueButtonTapped(_ sender: UIButton)
}

final class CreateSpacecraftView: BaseView {
    
    // MARK: - Properties
    weak var delegate: CreateSpacecraftViewDelegate?
    
    var name: String? {
        nameTextField.text
    }
    
    var durability: Int64 {
        Int64(titledSliderViews[0].sliderValue)
    }
    
    var speed: Int64 {
        Int64(titledSliderViews[1].sliderValue)
    }
    
    var capacity: Int64 {
        Int64(titledSliderViews[2].sliderValue)
    }
    
    var sumOfSliderValues: Float {
        titledSliderViews.reduce(0) { $0 + $1.sliderValue }
    }
    
    // MARK: - UI
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.placeholder = "Uzay Aracının Adı"
        return textField
    }()
    
    private lazy var titledSliderViews = [TitledSliderView]()
    
    private lazy var titledSliderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: titledSliderViews)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16.0
        return stackView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Devam Et", for: .normal)
        button.layer.borderWidth = 1.0
        if #available(iOS 13.0, *) {
            button.layer.borderColor = UIColor.label.cgColor
        } else {
            button.layer.borderColor = UIColor.black.cgColor
        }
        return button
    }()
    
    // MARK: - Setup
    override func linkInteractor() {
        super.linkInteractor()
        createTitledSliderViews()
        setTitledSlidersDelegate(self)
        continueButton.addTarget(self, action: #selector(didContinueButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        setupNameTextFieldLayout()
        setupTitledSliderStackViewLayout()
        setupContinueButtonLayout()
    }
    
    // MARK: - Methods
    private func setupNameTextFieldLayout() {
        addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.leading.equalTo(16.0)
            if #available(iOS 11.0, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32.0)
            } else {
                make.top.equalTo(76.0)
            }
            make.trailing.equalTo(-16.0)
            make.height.equalTo(48.0)
        }
    }
    
    private func setupTitledSliderStackViewLayout() {
        addSubview(titledSliderStackView)
        titledSliderStackView.snp.makeConstraints { make in
            make.leading.equalTo(16.0)
            make.trailing.equalTo(-16.0)
            make.center.equalToSuperview()
        }
    }
    
    private func setupContinueButtonLayout() {
        addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.width.equalTo(240.0)
            make.height.equalTo(64.0)
            make.centerX.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16.0)
            } else {
                make.bottom.equalTo(-36.0)
            }
        }
    }
    
    private func createTitledSliderViews() {
        for attribute in SpacecraftAttribute.allCases {
            let titledSliderView = TitledSliderView(title: attribute.rawValue)
            titledSliderViews.append(titledSliderView)
        }
    }
    
    private func setTitledSlidersDelegate(_ delegate: TitledSliderViewDelegate) {
        titledSliderViews.forEach { $0.delegate = delegate }
    }
}

// MARK: Enums
extension CreateSpacecraftView {
    enum SpacecraftAttribute: String, CaseIterable {
        case durability = "Dayanıklılık"
        case speed = "Hız"
        case capacity = "Kapasite"
    }
}

// MARK: - TitledSliderViewDelegate
extension CreateSpacecraftView: TitledSliderViewDelegate {
    func didSliderValueChanged(_ slider: UISlider) {
        delegate?.didSumOfSliderValuesChanged(slider, sumOfSliderValues: sumOfSliderValues)
    }
}

// MARK: - Actions
extension CreateSpacecraftView {
    @objc
    private func didContinueButtonTapped(_ sender: UIButton) {
        delegate?.didContinueButtonTapped(sender)
    }
}
