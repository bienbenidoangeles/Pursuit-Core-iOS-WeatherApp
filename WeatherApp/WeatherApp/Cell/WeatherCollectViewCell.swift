//
//  WeatherCollectViewCell.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherCollectViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    //var passedWeatherObj: DataForDay?
    
    func configureCell(for weatherObj: DataForDay){
        dateLabel.text = weatherObj.sunsetTime.description
        weatherImageView.image = UIImage(named: weatherObj.icon)
        temperatureLabel.text = "High: \(Int(weatherObj.temperatureHigh)) deg F\nLow:\(Int(weatherObj.temperatureLow)) deg F"
    }
}
