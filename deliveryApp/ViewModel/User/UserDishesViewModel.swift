//
//  UserDishesViewModel.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 23.11.21.
//

import Foundation
import CoreData

class UserDishesViewModel {
    
    weak var coreDataService: CoreDataService?
    
    
    private var DishesList: [NSManagedObject] = [NSManagedObject]()
}
