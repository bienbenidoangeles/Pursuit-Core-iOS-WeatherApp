//
//  PhotoModel.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct PhotoData: Codable & Equatable{
    let totalHits: Int
    let hits: [Photo]
}

struct Photo: Codable & Equatable{
    let largeImageURL: String
    let webformatHeight: Int
    let webformatWidth: Int
    let previewURL: String
    var favorited: Bool?
}
