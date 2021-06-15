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
            favoriteStations = stations?.filter({  $0.isFavorite ?? false })
        }
    }
    
    private var favoriteStations: [Station]?
    
    var numberOfItems: Int {
        favoriteStations?.count ?? .zero
    }
    
    func configureMyFavoriteTableViewCell(_ cell: MyFavoritesTableViewCell, forIndexPath indexPath: IndexPath) {
        let station = favoriteStations?[indexPath.item]
        cell.title = station?.name
        cell.subtitle = "(\(station?.coordinateX ?? .zero), \(station?.coordinateY ?? .zero)"
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
