//
//  ViewModel.swift
//  Weather-App
//
//  Created by Utku Can BALKIR on 10.03.2022.
//

import UIKit

class ViewModel {
    // MARK: - Response
    
    var weather: WeatherModel?
    
    
    // MARK: - Properties
    var temperatureString: String {
        return displayableCelciusTemperature(weather?.main.temp ?? 0)
    }
    
    var locationString: String {
        return String(weather?.name ?? "New York, USA")
    }
    
    var feelsLikeString: String {
        return displayableCelciusTemperature(weather?.main.feelsLike ?? 0)
    }

    var tempMaxString: String {
        return displayableCelciusTemperature(weather?.main.tempMax ?? 0)
    }
    
    var tempMinString: String {
        return displayableCelciusTemperature(weather?.main.tempMin ?? 0)
    }
    
    var humidityString: String {
        return String(weather?.main.humidity ?? 0)
    }
    
    var pressureString: String {
        return String(weather?.main.pressure ?? 0)
    }
    
    // MARK: - Helpers
    
    private func displayableCelciusTemperature(_ temperatureAsKelvin: Double) -> String {
        String(format:"%.1f", temperatureAsKelvin.kelvinToCelcius) + "° C"
    }
    
    // MARK: - Requests
    
    func fetchWeather(for cityId: Int = 5128581, _ completion: @escaping(() -> Void)) {
        NetworkController.fetchWeather(for: cityId) { weather in
            self.weather = weather
            completion()
            
        }
    }
}
