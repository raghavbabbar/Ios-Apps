//
//  Pin+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by raghav babbar on 15/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
import CoreData


extension Pin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin")
    }

    @NSManaged public var long: Double
    @NSManaged public var lat: Double
    @NSManaged public var page: Int32
    @NSManaged public var image: NSSet?
    
    
    convenience init(latitude: Double, longitude: Double, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Pin", in:context){
            self.init(entity: ent, insertInto: context)
            self.lat = latitude
            self.long = longitude
            self.page = 1
        } else {
            fatalError("Cannot find entity")
        }
    }


}

// MARK: Generated accessors for image
extension Pin {

    @objc(addImageObject:)
    @NSManaged public func addToImage(_ value: Images)

    @objc(removeImageObject:)
    @NSManaged public func removeFromImage(_ value: Images)

    @objc(addImage:)
    @NSManaged public func addToImage(_ values: NSSet)

    @objc(removeImage:)
    @NSManaged public func removeFromImage(_ values: NSSet)

}
