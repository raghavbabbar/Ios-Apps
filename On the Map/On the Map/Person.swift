//
//  Person.swift
//  On the Map
//
//  Created by raghav babbar on 13/08/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
import MapKit
class Person
{
    var firstName = ""
    var long:Double = 0.0
    var lat:Double = 0.0
    var url = ""
    var key = ""
    var objId=""
    var mapString = ""
    var link = ""
    var lastName=""
    init(key:String,name:String)
    {
    }
    init()
    {
    }
    init(obj:[String:Any]   )
    {
        self.firstName = "\(obj["firstName"] ?? "")"
        
        self.lastName =   "\(obj["lastName"] ?? "")"
        
        self.long=obj["longitude"] as? Double ?? 0
        
        self.lat = obj["latitude"] as? Double ?? 0
        
        self.url = "\(obj["mediaURL"] ?? "") "
        
        self.objId = "\(obj["objectId"]  ?? "")"
        
        self.mapString = "\(obj["mapString"] ?? "")"
        
        self.link = "\(obj["mediaURL"] ?? "")"
        
    }
    
    func getAnnotion()->MKPointAnnotation
    {
        let  annotion = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotion.coordinate=coordinate
        annotion.title=self.firstName + self.lastName
        annotion.subtitle=self.url
        return annotion
        
    }
}
