//
//  HomeViewModel.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import Foundation

final class HomeViewModel {
    var numberOfItems: Int {
        8
    }
    
    func configureHomeView(_ view: HomeView) {
        view.spacecraftName = "Uzay Aracı Adı"
        view.damageCapacity = 100
        view.stationName = "İstasyon Adı"
        view.time = 49
    }
    
    func configureStationCollectionViewCell(_ cell: StationCollectionViewCell) {
        cell.capacity = "00000/00000"
        cell.universalSpaceTime = "000EUS"
        cell.name = "İstasyon Adı"
    }
}
