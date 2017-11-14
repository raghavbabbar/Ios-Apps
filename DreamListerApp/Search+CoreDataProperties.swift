//
//  Search+CoreDataProperties.swift
//  DreamListerApp
//
//  Created by raghav babbar on 08/11/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//
//

import Foundation
import CoreData


extension Search {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var name: String?
    @NSManaged public var shop_name: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var price: String?
    @NSManaged public var shoping_url: String?
    @NSManaged public var img: NSObject?

}
