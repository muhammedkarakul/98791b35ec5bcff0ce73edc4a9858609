//
//  HomeViewModel.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import CoreData

final class HomeViewModel: CoreDataAccessible {
    // MARK: - Properties
    
    private var stations: [Station]? {
        didSet {
            currentStation = stations?.filter({ $0.isCurrent ?? false }).last
        }
    }
    
    private var currentStation: Station?
    
    private var spacecraft: Spacecraft?
    
    var numberOfItems: Int {
        stations?.count ?? 0
    }
    
    var configuredTitle: String? {
        "UGS: \(spacecraft?.ugs ?? .zero)  EUS: \(spacecraft?.eus ?? .zero) DS: \(spacecraft?.ds ?? .zero)"
    }
    
    var dsTimerInterval: Int64 {
        (spacecraft?.ds ?? .zero) / 1000
    }
    
    // MARK: - Methods
    func configureHomeView(_ view: HomeView) {
        view.spacecraftName = spacecraft?.name
        view.damageCapacity = spacecraft?.damageCapacity
        view.stationName = currentStation?.name
        view.time = dsTimerInterval
        view.layoutIfNeeded()
    }
    
    func configureStationCollectionViewCell(_ cell: StationCollectionViewCell, forIndexPath indexPath: IndexPath) {
        guard let station = stations?[indexPath.item], let currentStation = currentStation else { return }
        if station == currentStation || station.need == 0 {
            cell.isUserInteractionEnabled = false
            cell.contentView.alpha = 0.5
        } else {
            cell.isUserInteractionEnabled = true
            cell.contentView.alpha = 1.0
        }
        cell.capacity = "\(station.capacity)/\(station.stock)"
        cell.universalSpaceTime = "\(station.getDistanceToStation(currentStation))EUS"
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
    
    func addFavorite(forIndexPath indexPath: IndexPath, completion: @escaping (Error?) -> Void) {
        guard let station = stations?[indexPath.item] else { return }
        station.isFavorite?.toggle()
        station.update(value: station.isFavorite ?? false, forKey: "isFavorite", completion: completion)
    }
    
    func setCurrent(forIndexPath indexPath: IndexPath, completion: @escaping (Error?) -> Void) {
        
        resetIsCurrentForAllStations(completion: completion)
        
        guard let station = stations?[indexPath.item], let currentStation = currentStation else { return }
        
        spacecraft?.travel(to: station, from: currentStation)
        
        station.isCurrent?.toggle()
        stations?[indexPath.item] = station
        station.update(value: station.isCurrent ?? false, forKey: "isCurrent", completion: completion)
    }
    
    private func resetIsCurrentForAllStations(completion: @escaping (Error?) -> Void) {
        stations?.forEach { station in
            station.isCurrent = false
            station.update(value: station.isCurrent ?? false, forKey: "isCurrent", completion: completion)
        }
    }
    
    func decreaseDamageCapacity(completion: @escaping (Error?) -> Void) {
        spacecraft?.damageCapacity -= 1
        spacecraft?.update(value: spacecraft?.damageCapacity ?? .zero, forKey: "damageCapacity", completion: completion)
    }
}
