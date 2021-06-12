//
//  CreateSpacecraftViewController.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit

final class CreateSpacecraftViewController: BaseViewController<CreateSpacecraftView> {

    // MARK: - Properties
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
}
