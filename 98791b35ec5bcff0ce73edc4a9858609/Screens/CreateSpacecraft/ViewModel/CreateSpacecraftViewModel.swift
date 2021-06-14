//
//  CreateSpacecraftViewModel.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit
import CoreData

final class CreateSpacecraftViewModel: UserDefaultsAccessible, CoreDataAccessible {
    
    // MARK: Properties
    private var stations: [Station]?
    
    // MARK: - Methods
    func saveSpacecraft(withName name: String,
                        durability: Int64,
                        speed: Int64,
                        capacity: Int64,
                        completion: (Error?) -> Void) {
        
        let spacecraft = Spacecraft(name: name,
                                    durability: durability,
                                    speed: speed,
                                    capacity: capacity,
                                    damageCapacity: 100)
        
        spacecraft.save(completion: completion)
    }
    
    func getStations(completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/e7211664-cbb6-4357-9c9d-f12bf8bab2e2") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let stations = try JSONDecoder().decode([Station].self, from: data)
                self.stations = stations
                self.stations?.forEach { $0.save(completion: completion) }
                completion(nil)
            } catch {
                completion(error)
            }
        }.resume()
    }
}
