//
//  PhotoModel.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct PhotoData: Codable {
    let totalHits: Int
    let hits: [Photo]
}

struct Photo: Codable {
    let largeImageURL: String
    let webformatHeight: Int
    let webformatWidth: Int
    let likes: Int
    let id:Int
    let views: Int
    let comments: Int
    let webformatURL: String
    let tags: String
    let downloads: Int
    let user: String
    let previewURL: String
    var favorited: Bool?
}
