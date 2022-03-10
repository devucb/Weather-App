//
//  Weather.swift
//  Weather-App
//
//  Created by Utku Can BALKIR on 10.03.2022.
//

import Foundation
struct WeatherModel: Decodable {
    
    var name: String
    var main: Main
    
    struct Main: Decodable {
        
        var temp: Double
        var feelsLike: Double
        var tempMin: Double
        var tempMax: Double
        var pressure: Double
        var humidity: Double
       
        enum CodingKeys: String, CodingKey {
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case temp
            case pressure
            case humidity
        }
      }
    
}


