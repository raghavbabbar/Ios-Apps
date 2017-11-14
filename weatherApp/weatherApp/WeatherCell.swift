//
//  WeatherCell.swift
//  weatherApp
//
//  Created by raghav babbar on 12/05/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(obj:Forecast)
    { lowTemp.text=obj.lowtemp
      highTemp.text=obj._highTemp
      weatherType.text=obj.weathertypr
      dayLabel.text=obj.date
      weatherIcon.image=UIImage(named: weatherType.text!)
    }
    
   

}
