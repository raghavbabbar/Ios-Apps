//
//  ViewController.swift
//  weatherApp
//
//  Created by raghav babbar on 07/05/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var obj:CurrentWeather!
    var fobj=[Forecast]()
    let location=CLLocationManager()
    var currentlocation:CLLocation!
    override func viewDidLoad(){
        super.viewDidLoad()
        location.delegate=self as? CLLocationManagerDelegate
        location.desiredAccuracy=kCLLocationAccuracyBest
        location.requestWhenInUseAuthorization()
        location.startMonitoringSignificantLocationChanges()
        table.delegate=self
        table.dataSource=self
         obj = CurrentWeather()
        }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        permisionAuth()
        obj.downloadWeatherDetail{
            self.updateUI()
            self.downloadForeCastDate {
                self.table.reloadData()
            }
            
        }

    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return fobj.count
    }
    
          public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    if let c = tableView.dequeueReusableCell(withIdentifier: "cell") as? WeatherCell
    {c.configureCell(obj: self.fobj[indexPath.row])
    return c
    }
    else
    {
    return UITableViewCell()
    }
    
    }

func updateUI()
{
 date.text=obj.date
 temp.text="\(obj.currenttemp)"
 type.text=obj.weathertype
 city.text=obj.cityname
image.image=UIImage(named:obj.weathertype)
}

func downloadForeCastDate(function:@escaping completed)
{
let furl=URL(string: FORECASTURL)!
let v=URLSession.shared
let task=v.dataTask(with: furl) { (Data, response, error) in
    do{ print("--------------------uuuu------------")
        print(Data)
        print("---------------------uu-----------")
    let d=try JSONSerialization.jsonObject(with: Data!, options: .allowFragments)
        
        if let data=d as? [String:Any], let lst = data["list"] as? [[String:Any]]
        { for obj in lst
        { let f=Forecast(w:obj)
          self.fobj.append(f)
          print(obj)
        }
        
        }
        function()

    }
    catch
    {
    }
    }
    task.resume()
}
    
func permisionAuth()
{   //if CLLocation.Cll  == .authorizedWhenInUse

    currentlocation=location.location
    Location.shraeInstance.latitute = currentlocation.coordinate.latitude
    Location.shraeInstance.longitude=currentlocation.coordinate.longitude
    print("----------------------------")
    print(currentlocation.coordinate.latitude , currentlocation.coordinate.longitude)
    print("----------------------------")


}
    
}

