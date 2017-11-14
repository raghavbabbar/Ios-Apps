//
//  Global.swift
//  On the Map
//
//  Created by raghav babbar on 13/08/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
import MapKit
struct Globaldata
{
    static var personData=[Person]()
    static var annoiation=[MKPointAnnotation]()
    static var login = Person()
    static func addToGlobalData(person:Person ,_ annotion  :MKPointAnnotation? )
    {
        personData.append(person)
        if annotion != nil
        {
            annoiation.append(annotion!)
        }
    }
    
    
}
func urlForRequest(apiMethod: String?, parameters: [String : AnyObject]? = nil) -> URL {
    
    var cmp = URLComponents()
    cmp.scheme = "https"
    cmp.host = "parse.udacity.com"
    cmp.path = "/parse/classes"
        + (apiMethod ?? "")
    
    if let parameters = parameters {
        
        
        cmp.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            print("\n \(key )   \(value)")
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            cmp.queryItems?.append(queryItem)
        }
    }
    
    //print("\n ans is  \(cmp.url?.absoluteString)")
    return cmp.url!
}
