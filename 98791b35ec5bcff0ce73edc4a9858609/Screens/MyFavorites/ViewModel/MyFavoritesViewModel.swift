//
//  MyFavoritesViewModel.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 15.06.2021.
//

import CoreData

final class MyFavoritesViewModel: CoreDataAccessible {
    
    private var stations: [Station]? {
        didSet {
            earthStation = stations?.filter({ $0.name == "Dünya"}).first
            favoriteStations = stations?.filter({  $0.isFavorite ?? false })
        }
    }
    
    private var earthStation: Station?
    
    private var favoriteStations: [Station]?
    
    var numberOfItems: Int {
        favoriteStations?.count ?? .zero
    }
    
    func configureMyFavoriteTableViewCell(_ cell: MyFavoritesTableViewCell, forIndexPath indexPath: IndexPath) {
        guard let station = favoriteStations?[indexPath.item], let earthStation = earthStation else { return }
        cell.title = station.name
        cell.subtitle = "\(station.getDistanceToStation(earthStation))EUS"
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
}
