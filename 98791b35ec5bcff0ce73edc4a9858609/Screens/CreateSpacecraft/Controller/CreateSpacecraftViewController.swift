//
//  CreateSpacecraftViewController.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit

final class CreateSpacecraftViewController: BaseViewController<CreateSpacecraftView> {

    // MARK: - Properties
    private let viewModel = CreateSpacecraftViewModel()
    
    private let totalAttributeScore: Float = 15.0
    
    private var usedAttributedScore: Float = 0 {
        didSet {
            title = "Dağıtılacak Puan: \(Int(totalAttributeScore - usedAttributedScore))"
        }
    }
    
    // MARK: - Setup
    override func configureAppearance() {
        super.configureAppearance()
        title = "Dağıtılacak Puan: \(Int(totalAttributeScore))"
    }
    
    override func linkInteractor() {
        super.linkInteractor()
        baseView.delegate = self
    }
}

extension CreateSpacecraftViewController: CreateSpacecraftViewDelegate {
    func didSumOfSliderValuesChanged(_ sender: UISlider, sumOfSliderValues sum: Float) {
        
        if sum > totalAttributeScore {
            let overflow = sum - totalAttributeScore
            sender.value = sender.value - overflow
        }
        
        if sum < totalAttributeScore {
            usedAttributedScore = sum
        }
    }
    
    func didContinueButtonTapped(_ sender: UIButton) {
        if let name = baseView.name, name.isEmpty == false {
            if baseView.durability == 0 {
                showError(message: "Dayanıklılık 0 olamaz.")
            } else if baseView.speed == 0 {
                showError(message: "Hız 0 olamaz.")
            } else if baseView.capacity == 0 {
                showError(message: "Kapasite 0 olamaz.")
            } else {
                viewModel.saveSpacecraft(withName: name,
                                         durability: baseView.durability,
                                         speed: baseView.speed,
                                         capacity: baseView.capacity) { error in
                    if let error = error {
                        print("Uzay aracı kaydedilemedi. \(error), \(error.userInfo)")
                        return
                    }
                    viewModel.setUserDefaultsValue(true, forKey: .isSpaceCraftCreated)
                    let mainTabBarController = MainTabBarController()
                    navigationController?.pushViewController(mainTabBarController, animated: true)
                }
                
                
            }
        } else {
            showError(message: "İsim alanı boş bırakılamaz.")
        }
    }
}
