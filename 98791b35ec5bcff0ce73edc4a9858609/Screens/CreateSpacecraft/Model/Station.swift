//
//  Station.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 15.06.2021.
//

import CoreData

class Station: Codable {
    let name: String?
    let coordinateX: Float
    let coordinateY: Float
    let capacity: Int64
    var stock: Int64
    var need: Int64
    var isFavorite: Bool?
    var isCurrent: Bool?
    
    init(name: String?,
         coordinateX: Float,
         coordinateY: Float,
         capacity: Int64,
         stock: Int64,
         need: Int64,
         isFavorite: Bool,
         isCurrent: Bool) {
        
        self.name = name
        self.coordinateX = coordinateX
        self.coordinateY = coordinateY
        self.capacity = capacity
        self.stock = stock
        self.need = need
        self.isFavorite = isFavorite
        self.isCurrent = isCurrent
    }
    
    init(fromManagedObject managedObject: NSManagedObject) {
        name = managedObject.value(forKey: "name") as? String
        coordinateX = managedObject.value(forKey: "coordinateX") as! Float
        coordinateY = managedObject.value(forKey: "coordinateY") as! Float
        stock = managedObject.value(forKey: "stock") as! Int64
        capacity = managedObject.value(forKey: "capacity") as! Int64
        need = managedObject.value(forKey: "need") as! Int64
        isFavorite = managedObject.value(forKey: "isFavorite") as? Bool
        isCurrent = managedObject.value(forKey: "isCurrent") as? Bool
    }
}

// MARK: - Saveable
extension Station: Saveable {
    var entityName: String {
        "Station"
    }
    
    var data: [String : Any] {
        ["name" : name ?? "",
         "coordinateX" : coordinateX,
         "coordinateY" : coordinateY,
         "capacity" : capacity,
         "stock" : stock,
         "need" : need,
         "isFavorite" : isFavorite ?? false,
         "isCurrent" : isCurrent ?? false]
    }
}

// MARK: - Equatable
extension Station: Equatable {
    static func == (lhs: Station, rhs: Station) -> Bool {
        lhs.name == rhs.name
    }
}

// MARK: - Methods
extension Station {
    func getDistanceToStation(_ station: Station) -> Int64 {
        Int64(sqrt(pow(station.coordinateX - coordinateX, 2) + pow(station.coordinateY - coordinateY, 2)))
    }
}
