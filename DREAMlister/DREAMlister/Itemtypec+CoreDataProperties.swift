//
//  Itemtypec+CoreDataProperties.swift
//  DREAMlister
//
//  Created by raghav babbar on 28/05/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
import CoreData


extension Itemtypec {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Itemtypec> {
        return NSFetchRequest<Itemtypec>(entityName: "Itemtypec")
    }

    @NSManaged public var type: String?
    @NSManaged public var toitem: Itemc?

}
