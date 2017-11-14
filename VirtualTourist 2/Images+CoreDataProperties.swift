//
//  Images+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by raghav babbar on 15/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
import CoreData


extension Images {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Images> {
        return NSFetchRequest<Images>(entityName: "Images")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var url: String?
    @NSManaged public var pin: Pin?
    
    convenience init(image:NSData?, point :Pin ,context: NSManagedObjectContext) {
        if let entty = NSEntityDescription.entity(forEntityName: "Images", in: context){
            self.init(entity: entty, insertInto: context)
            self.image = image
            self.pin = point
        } else {
            fatalError("Can't Find Entity")
        }
    }


}
