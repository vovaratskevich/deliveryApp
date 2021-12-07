//
//  Order+CoreDataProperties.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 7.12.21.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var adress: String?
    @NSManaged public var id: Int16
    @NSManaged public var login: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var status: String?
    @NSManaged public var surname: String?
    @NSManaged public var company: NSSet?
    @NSManaged public var dish: NSSet?
    @NSManaged public var owner: User?

}

// MARK: Generated accessors for company
extension Order {

    @objc(addCompanyObject:)
    @NSManaged public func addToCompany(_ value: Company)

    @objc(removeCompanyObject:)
    @NSManaged public func removeFromCompany(_ value: Company)

    @objc(addCompany:)
    @NSManaged public func addToCompany(_ values: NSSet)

    @objc(removeCompany:)
    @NSManaged public func removeFromCompany(_ values: NSSet)

}

// MARK: Generated accessors for dish
extension Order {

    @objc(addDishObject:)
    @NSManaged public func addToDish(_ value: Dish)

    @objc(removeDishObject:)
    @NSManaged public func removeFromDish(_ value: Dish)

    @objc(addDish:)
    @NSManaged public func addToDish(_ values: NSSet)

    @objc(removeDish:)
    @NSManaged public func removeFromDish(_ values: NSSet)

}

extension Order : Identifiable {

}
