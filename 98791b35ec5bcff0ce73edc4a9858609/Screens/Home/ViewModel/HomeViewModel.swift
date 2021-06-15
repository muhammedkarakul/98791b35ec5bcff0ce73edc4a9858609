//
//  HomeViewModel.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import CoreData

final class HomeViewModel: CoreDataAccessible {
    // MARK: - Properties
    
    private var stations: [Station]?
    
    private var spacecraft: Spacecraft?
    
    var numberOfItems: Int {
        stations?.count ?? 0
    }
    
    // MARK: - Methods
    func configureHomeView(_ view: HomeView) {
        view.spacecraftName = spacecraft?.name
        view.damageCapacity = spacecraft?.damageCapacity
        view.stationName = "Dünya"
        view.time = 49
    }
    
    func configureStationCollectionViewCell(_ cell: StationCollectionViewCell, forIndexPath indexPath: IndexPath) {
        guard let station = stations?[indexPath.item] else { return }
        cell.capacity = "\(station.capacity)/\(station.stock)"
        cell.universalSpaceTime = "(\(station.coordinateX), \(station.coordinateY))"
        cell.name = station.name
        cell.isFavorite = station.isFavorite ?? false
    }
    
    func fetchStations(completion: (Error?) -> Void) {
        fetchEntity(withName: "Station") { entity, error in
            if let error = error {
                completion(error)
                return
            }
            guard let managedObjects = entity as? [NSManagedObject] else { return }
            
            stations = managedObjects.map { Station(fromManagedObject: $0) }
            
            completion(nil)
        }
    }
    
    func fetchSpacecraft(completion: (Error?) -> Void) {
        fetchEntity(withName: "Spacecraft") { entity, error in
            if let error = error {
                completion(error)
                return
            }
            guard let managedObject = entity?.first as? NSManagedObject else { return }
            spacecraft = Spacecraft(fromManagedObject: managedObject)
            completion(nil)
        }
    }
    
    func addFavorite(forIndexPath indexPath: IndexPath, completion: (Error?) -> Void) {
        guard let station = stations?[indexPath.item] else { return }
        station.isFavorite?.toggle()
        station.update(value: station.isFavorite ?? false, forKey: "isFavorite", completion: completion)
    }
}
