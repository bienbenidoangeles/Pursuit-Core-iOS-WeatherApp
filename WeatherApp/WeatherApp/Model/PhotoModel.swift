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

extension Photo{
    enum CodingKeys:String, CodingKey {
        case largeImageURL
        case webformatHeight
        case webformatWidth
        case previewURL
        case favorited
    }
}

extension Photo: CustomStringConvertible{
    var description: String {
        return "largeImageURL: \(largeImageURL)\nwebformatHeight: \(webformatHeight)\nwebformatWidth: \(webformatWidth)\npreviewURL: \(previewURL)\nfavorited: \(favorited ?? false)"
    }
}
