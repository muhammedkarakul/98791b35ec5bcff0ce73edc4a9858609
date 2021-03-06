//
//  BaseView.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit

class BaseView: UIView {
    
    required init() {
        super.init(frame: .zero)
        linkInteractor()
        configureAppearance()
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func linkInteractor() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didRecognizeTapGesure(_:))))
    }
    
    func configureAppearance() {}
    
    func prepareLayout() {}
    
    static func create() -> Self {
        let view = Self()
        return view
    }
    
}

// MARK: - Actions
extension BaseView {
    @objc
    private func didRecognizeTapGesure(_ sender: UITapGestureRecognizer) {
        endEditing(true)
    }
}
