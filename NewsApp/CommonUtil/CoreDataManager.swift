//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-21.
//

import Foundation
import CoreData

internal struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        
        return container
    }()
}
