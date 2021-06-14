//
//  Spacecraft.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 15.06.2021.
//

import CoreData

struct Spacecraft: Codable {
    let name: String?
    let durability: Int64
    let speed: Int64
    let capacity: Int64
    let damageCapacity: Int64
    
    init(name: String?, durability: Int64, speed: Int64, capacity: Int64, damageCapacity: Int64) {
        self.name = name
        self.durability = durability
        self.speed = speed
        self.capacity = capacity
        self.damageCapacity = damageCapacity
    }
    
    init(fromManagedObject managedObject: NSManagedObject) {
        name = managedObject.value(forKey: "name") as? String
        durability = managedObject.value(forKey: "durability") as! Int64
        speed = managedObject.value(forKey: "speed") as! Int64
        capacity = managedObject.value(forKey: "capacity") as! Int64
        damageCapacity = managedObject.value(forKey: "damageCapacity") as! Int64
    }
}

extension Spacecraft: Saveable {
    var entityName: String {
        "Spacecraft"
    }
    
    var data: [String : Any] {
        ["name" : name ?? "",
         "durability" : durability,
         "speed" : speed,
         "capacity" : capacity,
         "damageCapacity" : damageCapacity]
    }
}
