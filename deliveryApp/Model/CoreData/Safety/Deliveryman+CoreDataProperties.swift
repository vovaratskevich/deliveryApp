//
//  Deliveryman+CoreDataProperties.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 2.12.21.
//
//

import Foundation
import CoreData


extension Deliveryman {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deliveryman> {
        return NSFetchRequest<Deliveryman>(entityName: "Deliveryman")
    }

    @NSManaged public var surname: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var owner: Company?

}

extension Deliveryman : Identifiable {

}
