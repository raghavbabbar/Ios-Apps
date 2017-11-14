//
//  Const.swift
//  Virtual_Tourist
//
//  Created by raghav babbar on 06/09/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
import UIKit
struct Flicker
{
    let sceme="https"
    let host="api.flickr.com"
    let path="/services/rest"
    
    
    
    
    
    
    
    
    
    
    
    func getData(lat :Double ,long :Double,page:Int32 ,completion : @escaping (_ error:String?,_ data:[String]?)->())
    {print(" downloadin2")
        let url = "https://api.flickr.com/services/rest?page=\(page)&method=flickr.photos.search&format=json&api_key=602f92453cba6224074f503e4b92150e&bbox=\(bbox(Lat:lat, Long: long))&extras=url_m&nojsoncallback=1"
        
        print(url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: URL(string : url)!) {
            data , response , error in
            if error != nil
            {
                completion(error?.localizedDescription, nil)
                return
            }
            
            
            
            let Data = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
            //  print(Data)
            if let photos = Data["photos"] as? [String:Any] ,let array = photos["photo"] as? [[String:Any]]
            {    print(" downloadin3")
                var count = array.count - 1
                
                var urlArray=[String]()
                
                if count > 20
                {
                    count = 20
                }
                while count > 0
                { count -= 1
                    let obj = array[count]
                    var url = obj["url_m"] as! String
                    urlArray.append(url)
                    
                }
                
                completion(nil,urlArray)
            }
            else
            {
                print(" downlo")
            }
        }
        
        task.resume()
        
    }
    
    
    
    
    func bbox( Lat: Double, Long: Double) -> String {
        let minimumLong =  min(Long + 1, 180)
        let maximumLong =  max(Long - 1,-180  )
        let minimumLat =  min(Lat + 1, 90)
        let maximumLat =  max(Lat - 1, -90)
        return "\(maximumLong),\(maximumLat),\(minimumLong),\(minimumLat)"
    }
    
    
}

