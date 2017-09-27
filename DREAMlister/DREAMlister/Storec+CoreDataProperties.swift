//
//  Storec+CoreDataProperties.swift
//  DREAMlister
//
//  Created by raghav babbar on 28/05/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
import CoreData


extension Storec {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Storec> {
        return NSFetchRequest<Storec>(entityName: "Storec")
    }

    @NSManaged public var name: String?
    @NSManaged public var toimage: Imagec?
    @NSManaged public var toitem: Itemc?

}
