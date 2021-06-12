//
//  BaseViewController.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit

class BaseViewController<T: BaseView>: UIViewController {
    
    // MARK: - Properties
    typealias ViewType = T
    
    var baseView: ViewType {
        guard let aView = view as? ViewType else {
            fatalError("view property has not been initialized yet, or not initialized as \(ViewType.self).")
        }
        return aView
    }
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        linkInteractor()
        configureAppearance()
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = ViewType.create()
    }
    
    // MARK: - Methods
    func linkInteractor() {}
    
    func configureAppearance() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    
    func prepareLayout() {}
}
