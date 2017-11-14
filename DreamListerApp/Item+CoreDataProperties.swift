//
//  Item+CoreDataProperties.swift
//  DreamListerApp
//
//  Created by raghav babbar on 29/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var details: String?
    @NSManaged public var title: String?
    @NSManaged public var image: NSObject?
    @NSManaged public var toStore: Store?

}
