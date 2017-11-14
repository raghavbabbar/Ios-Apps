//
//  Store+CoreDataProperties.swift
//  DreamListerApp
//
//  Created by raghav babbar on 29/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store")
    }

    @NSManaged public var name: String?
    @NSManaged public var toItem: Item?

}
