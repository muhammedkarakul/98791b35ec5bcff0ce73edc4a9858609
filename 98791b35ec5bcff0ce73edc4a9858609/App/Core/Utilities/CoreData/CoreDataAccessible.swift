//
//  UserDefaultAccessible.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 14.06.2021.
//

import UIKit
import CoreData

protocol CoreDataAccessible {}

extension CoreDataAccessible {
    var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    
    var managedContext: NSManagedObjectContext? {
        appDelegate?.persistentContainer.viewContext
    }
    
    func fetchEntity(withName entityName: String, completion: ([Any]?, Error?) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StationEntity")
        
        do {
            let fetch = try managedContext?.fetch(request)
            completion(fetch, nil)
        } catch let error as NSError {
            completion(nil, error)
        }
    }
}
