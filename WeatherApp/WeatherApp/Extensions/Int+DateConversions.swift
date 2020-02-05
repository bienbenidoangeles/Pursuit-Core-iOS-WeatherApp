//
//  Int+DateConversions.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

extension Int {
  func convertDate() -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(self))
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.medium
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = .current
    let localDate = dateFormatter.string(from: date)
    return localDate
  }
  func convertTime() -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(self))
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.medium
    dateFormatter.dateFormat = "h:mm a"
    dateFormatter.timeZone = .current
    let localDate = dateFormatter.string(from: date)
    return localDate
  }
}
