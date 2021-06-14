//
//  Spacecraft.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 14.06.2021.
//

import CoreData

struct Spacecraft: Codable {
    let name: String
    let durability: Int64
    let speed: Int64
    let capacity: Int64
    let damageCapacity: Int64
    let currentStation: Station
}

extension Spacecraft: Saveable {
    var entityName: String {
        "SpacecraftEntity"
    }
    
    var data: [String : Any] {
        ["name" : name,
         "durability" : durability,
         "speed" : speed,
         "capacity" : capacity,
         "damageCapacity" : damageCapacity]
    }
}
