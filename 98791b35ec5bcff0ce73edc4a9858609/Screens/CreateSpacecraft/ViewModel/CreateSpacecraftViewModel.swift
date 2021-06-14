//
//  CreateSpacecraftViewModel.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit

final class CreateSpacecraftViewModel: UserDefaultsAccessible {
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
}
