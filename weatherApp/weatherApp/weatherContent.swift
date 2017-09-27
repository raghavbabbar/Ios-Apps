//
//  constants.swift
//  weatherApp
//
//  Created by raghav babbar on 08/05/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
import  UIKit
class CurrentWeather
{   private var _cityName:String!
    private var _date:String!
    private var _currentTemp:Double!
    private var _weathertype:String!
 
    var cityname:String
    {if _cityName==nil
    {_cityName=""
        }
    return _cityName
    }
    
    var weathertype:String
    { if (_weathertype == nil)
    {_weathertype=""}
     return _weathertype    }
    var currenttemp:Double
    {if (_currentTemp == nil)
    {_currentTemp=0.0}
   return _currentTemp    }
    var date:String{
     if _date==nil
    {
    _date=""
    }
    let df=DateFormatter()
     df.dateStyle = .long
     df.timeStyle = .none
     let cd=df.string(from: Date())
     _date="Today \(cd)"
    return _date
    }
    func downloadWeatherDetail(comf:@escaping completed)
    {
        let url=URL(string: CURRENTURL)
        print(CURRENTURL)
        let s=URLSession.shared
    
        let task=s.dataTask(with: url!) { (Data, URLResponse, Error) in
            do{
                print(Data)
            let d=try JSONSerialization.jsonObject(with: Data!, options: .allowFragments)
                if let data=d as? [String:Any]
                {
                self._cityName=data["name"] as! String
                    print(self._cityName)
                    if let wd=data["weather"] as? [[String:Any]]
                    { self._weathertype=wd[0]["main"] as! String
                    // print(wd[0]["temp"])
                        if let t=data["main"] as? [String:Any]
                        { self._currentTemp=t["temp"] as? Double
                        }
                      print(self._weathertype)
                    
                    }
                
                 
                    
                    
                    
                }
            comf()
            }
            catch {
            }
        }
    
    
    task.resume()
    }
}
