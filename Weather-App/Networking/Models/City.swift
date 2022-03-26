//
//  City.swift
//  Weather-App
//
//  Created by Utku Can BALKIR on 13.03.2022.
//

import Foundation

struct City: Decodable {
    var id: Int
    var name: String
    var state: String
    var country: String
    var coord: Coord
}

struct Coord: Decodable {
    var lon: Double
    var lat: Double
}
