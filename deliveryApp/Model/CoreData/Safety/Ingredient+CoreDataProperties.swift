//
//  Ingredient+CoreDataProperties.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 2.12.21.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var count: Int16
    @NSManaged public var name: String?
    @NSManaged public var owner: Dish?

}

extension Ingredient : Identifiable {

}
