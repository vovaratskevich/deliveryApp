//
//  Dish+CoreDataProperties.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 2.12.21.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var imageName: String?
    @NSManaged public var ingridients: NSSet?
    @NSManaged public var owner: Order?

}

// MARK: Generated accessors for ingridients
extension Dish {

    @objc(addIngridientsObject:)
    @NSManaged public func addToIngridients(_ value: Ingredient)

    @objc(removeIngridientsObject:)
    @NSManaged public func removeFromIngridients(_ value: Ingredient)

    @objc(addIngridients:)
    @NSManaged public func addToIngridients(_ values: NSSet)

    @objc(removeIngridients:)
    @NSManaged public func removeFromIngridients(_ values: NSSet)

}

extension Dish : Identifiable {

}
