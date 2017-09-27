//
//  Imagec+CoreDataProperties.swift
//  DREAMlister
//
//  Created by raghav babbar on 28/05/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
import CoreData


extension Imagec {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Imagec> {
        return NSFetchRequest<Imagec>(entityName: "Imagec")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toitem: Itemc?
    @NSManaged public var tostore: NSSet?

}

// MARK: Generated accessors for tostore
extension Imagec {

    @objc(addTostoreObject:)
    @NSManaged public func addToTostore(_ value: Storec)

    @objc(removeTostoreObject:)
    @NSManaged public func removeFromTostore(_ value: Storec)

    @objc(addTostore:)
    @NSManaged public func addToTostore(_ values: NSSet)

    @objc(removeTostore:)
    @NSManaged public func removeFromTostore(_ values: NSSet)

}
