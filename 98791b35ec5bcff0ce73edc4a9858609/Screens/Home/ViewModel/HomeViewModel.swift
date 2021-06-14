//
//  HomeViewModel.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import CoreData

final class HomeViewModel: CoreDataAccessible {
    // MARK: - Properties
    
    private var stations: [StationEntity]?
    
    private var spacecraft: Spacecraft?
    
    var numberOfItems: Int {
        stations?.count ?? 0
    }
    
    // MARK: - Methods
    func configureHomeView(_ view: HomeView) {
        view.spacecraftName = spacecraft?.name
        view.damageCapacity = spacecraft?.damageCapacity
        view.stationName = spacecraft?.currentStation.name
        view.time = 49
    }
    
    func configureStationCollectionViewCell(_ cell: StationCollectionViewCell, forIndexPath indexPath: IndexPath) {
        guard let station = stations?[indexPath.item] else { return }
        cell.capacity = "\(station.capacity)/\(station.stock)"
        cell.universalSpaceTime = "(\(station.coordinateX), \(station.coordinateY))"
        cell.name = station.name
    }
    
    func fetchStations(completion: (Error?) -> Void) {
        fetchEntity(withName: "StationEntity") { entity, error in
            if let error = error {
                completion(error)
                return
            }
            stations = entity as? [StationEntity]
            completion(nil)
        }
    }
    
    func fetchSpacecraft(completion: (Error?) -> Void) {
        fetchEntity(withName: "SpacecraftEntity") { entity, error in
            if let error = error {
                completion(error)
                return
            }
            spacecraft = entity?.first as? Spacecraft
            completion(nil)
        }
    }
}
