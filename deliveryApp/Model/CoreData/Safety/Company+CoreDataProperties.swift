//
//  Company+CoreDataProperties.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 2.12.21.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var owner: Order?
    @NSManaged public var deliveryman: NSSet?

}

// MARK: Generated accessors for deliveryman
extension Company {

    @objc(addDeliverymanObject:)
    @NSManaged public func addToDeliveryman(_ value: Deliveryman)

    @objc(removeDeliverymanObject:)
    @NSManaged public func removeFromDeliveryman(_ value: Deliveryman)

    @objc(addDeliveryman:)
    @NSManaged public func addToDeliveryman(_ values: NSSet)

    @objc(removeDeliveryman:)
    @NSManaged public func removeFromDeliveryman(_ values: NSSet)

}

extension Company : Identifiable {

}
