//
//  User+CoreDataProperties.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 2.12.21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var accessory: String?
    @NSManaged public var email: String?
    @NSManaged public var login: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var surname: String?
    @NSManaged public var order: NSSet?

}

// MARK: Generated accessors for order
extension User {

    @objc(addOrderObject:)
    @NSManaged public func addToOrder(_ value: Order)

    @objc(removeOrderObject:)
    @NSManaged public func removeFromOrder(_ value: Order)

    @objc(addOrder:)
    @NSManaged public func addToOrder(_ values: NSSet)

    @objc(removeOrder:)
    @NSManaged public func removeFromOrder(_ values: NSSet)

}

extension User : Identifiable {

}
