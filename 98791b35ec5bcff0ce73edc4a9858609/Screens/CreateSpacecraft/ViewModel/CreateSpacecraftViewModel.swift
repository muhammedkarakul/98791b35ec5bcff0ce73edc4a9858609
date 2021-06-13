//
//  CreateSpacecraftViewModel.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 12.06.2021.
//

import UIKit
import CoreData

final class CreateSpacecraftViewModel {
    func saveSpacecraft(withName name: String, durability: Int16, speed: Int16, capacity: Int16, completion: (NSError?) -> Void) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Spacecraft", in: managedContext)!
        
        let spacecraft = NSManagedObject(entity: entity, insertInto: managedContext)
        
        spacecraft.setValue(name, forKeyPath: "name")
        spacecraft.setValue(durability, forKeyPath: "durability")
        spacecraft.setValue(speed, forKey: "speed")
        spacecraft.setValue(capacity, forKey: "capacity")
        spacecraft.setValue(100, forKey: "damageCapacity")
        
        do {
            try managedContext.save()
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }
}
