//
//  CreateSpacecraftView.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit

final class CreateSpacecraftView: BaseView {
    
    // MARK: - Properties
    var name: String? {
        nameTextField.text
    }
    
    // MARK: - UI
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.placeholder = "Uzay Aracının Adı"
        return textField
    }()
    
    
    private lazy var durabilityTitledSliderView: TitledSliderView = {
        let titledSliderView = TitledSliderView()
        titledSliderView.title = "Dayanıklılık"
        return titledSliderView
    }()
    
    private lazy var speedTitledSliderView: TitledSliderView = {
        let titledSliderView = TitledSliderView()
        titledSliderView.title = "Hız"
        return titledSliderView
    }()
    
    private lazy var capacityTitledSliderView: TitledSliderView = {
        let titledSliderView = TitledSliderView()
        titledSliderView.title = "Kapasite"
        return titledSliderView
    }()
    
    private lazy var titledSliderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [durabilityTitledSliderView,
                                                       speedTitledSliderView,
                                                       capacityTitledSliderView])
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
}
