//
//  HomeViewModel.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import CoreData

protocol HomeViewModelDelegate: AnyObject {
    func didErrorOccured(_ error : Error?)
    func didResponseFetched(_ response: [Station]?)
}

final class HomeViewModel {
    // MARK: - Properties
    weak var delegate: HomeViewModelDelegate?
    
    private var error: Error? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didErrorOccured(self.error)
            }
        }
    }
    
    private var stations: [Station]? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didResponseFetched(self.stations)
            }
        }
    }
    
    var numberOfItems: Int {
        stations?.count ?? 0
    }
    
    // MARK: - Methods
    func configureHomeView(_ view: HomeView) {
        view.spacecraftName = "Uzay Aracı Adı"
        view.damageCapacity = 100
        view.stationName = "İstasyon Adı"
        view.time = 49
    }
    
    func configureStationCollectionViewCell(_ cell: StationCollectionViewCell, forIndexPath indexPath: IndexPath) {
        guard let station = stations?[indexPath.item] else { return }
        cell.capacity = "\(station.capacity)/\(station.stock)"
        cell.universalSpaceTime = "(\(station.coordinateX), \(station.coordinateY))"
        cell.name = station.name
    }
    
    func getStations() {
        guard let url = URL(string: "https://run.mocky.io/v3/e7211664-cbb6-4357-9c9d-f12bf8bab2e2") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.error = error
                return
            }
            
            guard let data = data else { return }
            
            do {
                let stations = try JSONDecoder().decode([Station].self, from: data)
                self.stations = stations
            } catch {
                self.error = error
            }
        }.resume()
    }
}
