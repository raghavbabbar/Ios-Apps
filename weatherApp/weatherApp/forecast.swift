//
//  forecast.swift
//  weatherApp
//
//  Created by raghav babbar on 10/05/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
class Forecast
{
    var _date="XXX"
    var _weatherType:String!
    var _highTemp:String!
    var _lowtemp:String!
    init(w dict:[String:Any])
    {
        if let temp=dict["temp"] as? [String:Any]
    {
        print(temp)
    //    print("0-0-\(temp["max"] as! String )--")
     //   print("1--\(dict["temp"]["max"] as! Double) -- ")

        if let max = temp["max"] as? Double{
        self._highTemp="\(max)"
        }
        if let min = temp["min"] as? Double        {
        self._lowtemp="\(min)"
        }
        
        }
        if let w=dict["weather"] as?[[String:Any]],let type=w[0]["main"] as? String
        { self._weatherType=type
            
        }
        if let date=dict["dt"] as? Double
        {
            
        }
        print("--------------------------------")
       print(self._date)
       print(self._highTemp)
       print(self._lowtemp)
        print(self._weatherType)
    }
    init() {
     _date=""
     _weatherType=""
     _highTemp=""
     _lowtemp=""
    }
    var date:String{
    return _date
    }
    var weathertypr:String{
    return _weatherType}
    var hightemp:String
    {return _highTemp
    }
    var lowtemp:String
    {return _lowtemp
    }
}
