//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct Weather: Codable & Equatable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currently: CurrentWeather
    let daily: DailyWeather
    
}

struct CurrentWeather: Codable & Equatable {
    let time: Int
    let summary: String
    let icon: String
    let precipProbability: Double
    let temperature: Double
    let visibility: Double
    
}

struct DailyWeather:Codable & Equatable {
    let summary: String
    let icon: String
    let data: [DataForDay]
}

struct DataForDay: Codable & Equatable {
    let time: Int
    let summary: String
    let icon: String
    let sunriseTime: Int
    let sunsetTime: Int
    let precipProbability: Double
    let precipType: String?
    let windSpeed: Double
    let temperatureHigh: Double
    let temperatureLow: Double
}
