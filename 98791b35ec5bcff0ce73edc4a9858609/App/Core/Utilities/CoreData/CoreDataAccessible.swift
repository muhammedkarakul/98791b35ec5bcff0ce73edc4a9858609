//
//  CoreDataAccessible.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 14.06.2021.
//

import CoreData
import UIKit

protocol CoreDataAccessible {
    var entityName: String { get }
    var data: [String : Any] { get }
}

extension CoreDataAccessible {
    private var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    
    private var managedContext: NSManagedObjectContext? {
        appDelegate?.persistentContainer.viewContext
    }
    
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
}
