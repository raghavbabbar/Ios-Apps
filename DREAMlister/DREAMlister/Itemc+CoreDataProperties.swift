//
//  Itemc+CoreDataProperties.swift
//  DREAMlister
//
//  Created by raghav babbar on 28/05/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
import CoreData


extension Itemc {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Itemc> {
        return NSFetchRequest<Itemc>(entityName: "Itemc")
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var toimage: Imagec?
    @NSManaged public var toitemtype: Itemtypec?
    @NSManaged public var tostore: Storec?

}
