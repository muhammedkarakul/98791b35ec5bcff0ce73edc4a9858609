//
//  Station.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 14.06.2021.
//

import Foundation

struct Station: Codable {
    let name: String
    let coordinateX: Float
    let coordinateY: Float
    let capacity: Int64
    let stock: Int64
    let need: Int64
}

extension Station: Saveable {
    var entityName: String {
        "StationEntity"
    }
    
    var data: [String : Any] {
        ["name" : name,
         "coordinateX" : coordinateX,
         "coordinateY" : coordinateY,
         "capacity" : capacity,
         "stock" : stock,
         "need" : need]
    }
}
