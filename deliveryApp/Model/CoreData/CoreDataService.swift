//
//  CoreDataService.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 23.11.21.
//

import Foundation
import CoreData

class CoreDataService {
    
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "nordgold_hr_services")
            container.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Unable to load persistent stores: \(error)")
                }
            }
            return container
    }()
    
    private func saveIfContextHasChanges() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
