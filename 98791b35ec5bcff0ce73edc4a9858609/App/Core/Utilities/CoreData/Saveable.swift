//
//  Saveable.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 14.06.2021.
//

import CoreData
import UIKit

protocol Saveable: CoreDataAccessible {
    var name: String? { get }
    var entityName: String { get }
    var data: [String : Any] { get }
}

extension Saveable {
    
    func save(completion: (Error?) -> Void) {
        guard let managedContext = managedContext,
              let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else { return }
        
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        
        for item in data {
            object.setValue(item.value, forKey: item.key)
        }
        
        do {
            try managedContext.save()
            completion(nil)
        } catch let error as NSError {
            debugPrint("The data could not be saved to the database. \(error)")
            completion(error)
        }
    }
    
    func update(value: Any, forKey key: String, completion: ((Error?) -> Void)? = nil) {
        let context = managedContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        guard let name = name else { return }
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            guard let results = try context?.fetch(fetchRequest) else { return }
            
            if results.count > 0 {
                results.first?.setValue(value, forKey: key)
                try context?.save()
            }
            completion?(nil)
        } catch {
            completion?(error)
        }
    }
}
