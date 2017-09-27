//
//  constant.swift
//  weatherApp
//
//  Created by raghav babbar on 08/05/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation
//http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b1b15e88fa797225412429c1c50c122a1
let baseURL="http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE="&lon="
let APPI_ID="&appid="
let APi_key="1323fb17cdd70628fde08d276367f527"
let CURRENTURL="\(baseURL)\(LATITUDE)30.4840\(LONGITUDE)76.5940\(APPI_ID)\(APi_key)"
/*https://samples.openweathermap.org/data/2.5/forecast/daily?lat=30.3397809&lon=76.3868797&cnt=10&appid=b1b15e88fa797225412429c1c50c122a1*/
let FORECASTURL="http://api.openweathermap.org/data/2.5/forecast/daily?lat=30&lon=76.5940&cnt=10&appid=1323fb17cdd70628fde08d276367f527"
typealias completed = ()->()
/*http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=1323fb17cdd70628fde08d276367f527*/
