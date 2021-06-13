//
//  AlertPresentable.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import UIKit

protocol AlertPresentable {
    func showError(message: String)
}

extension AlertPresentable where Self: UIViewController {
    func showError(message: String) {
        let defaultAction = UIAlertAction(title: "Tamam", style: .default)
        showAlert(title: "Hata", message: message, prefferedStyle: .alert, actions: defaultAction)
    }
    
    private func showAlert(title: String, message: String, prefferedStyle: UIAlertController.Style, actions: UIAlertAction...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: prefferedStyle)
        actions.forEach { alert.addAction($0)}
        present(alert, animated: true)
    }
}
