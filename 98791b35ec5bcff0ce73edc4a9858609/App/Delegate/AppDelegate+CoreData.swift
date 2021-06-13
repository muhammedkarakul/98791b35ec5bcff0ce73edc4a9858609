//
//  AppDelegate+CoreData.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import CoreData

extension AppDelegate {
    var persistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "_8791b35ec5bcff0ce73edc4a9858609")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }
}
