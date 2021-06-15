//
//  Spacecraft.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 15.06.2021.
//

import CoreData

class Spacecraft: Codable {
    let name: String?
    let durability: Int64
    let speed: Int64
    let capacity: Int64
    var damageCapacity: Int64
    var ugs: Int64
    var eus: Int64
    var ds: Int64
    
    init(name: String?,
         durability: Int64,
         speed: Int64,
         capacity: Int64,
         damageCapacity: Int64,
         ugs: Int64,
         eus: Int64,
         ds: Int64) {
        
        self.name = name
        self.durability = durability
        self.speed = speed
        self.capacity = capacity
        self.damageCapacity = damageCapacity
        self.ugs = ugs
        self.eus = eus
        self.ds = ds
    }
    
    init(fromManagedObject managedObject: NSManagedObject) {
        name = managedObject.value(forKey: "name") as? String
        durability = managedObject.value(forKey: "durability") as! Int64
        speed = managedObject.value(forKey: "speed") as! Int64
        capacity = managedObject.value(forKey: "capacity") as! Int64
        damageCapacity = managedObject.value(forKey: "damageCapacity") as! Int64
        ugs = managedObject.value(forKey: "ugs") as! Int64
        eus = managedObject.value(forKey: "eus") as! Int64
        ds = managedObject.value(forKey: "ds") as! Int64
    }
}

// MARK: - Saveable
extension Spacecraft: Saveable {
    var entityName: String {
        "Spacecraft"
    }
    
    var data: [String : Any] {
        ["name" : name ?? "",
         "durability" : durability,
         "speed" : speed,
         "capacity" : capacity,
         "damageCapacity" : damageCapacity,
         "ugs": ugs,
         "eus" : eus,
         "ds": ds]
    }
}

// MARK: - Methods
extension Spacecraft {
    func travel(to station: Station, from currentStation: Station) {
        if ugs < station.need || eus < station.getDistanceToStation(currentStation) {
            NotificationCenter.default.post(name: .gameOver, object: nil)
        } else {
            ugs = ugs - station.need
            update(value: ugs, forKey: "ugs")
            
            eus = eus - station.getDistanceToStation(currentStation)
            update(value: eus, forKey: "eus")
            
            station.need = .zero
            station.stock = station.capacity
            station.update(value: station.need, forKey: "need")
            station.update(value: station.stock, forKey: "stock")
        }
    }
}
