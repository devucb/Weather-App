//
//  ViewModel.swift
//  Weather-App
//
//  Created by Utku Can BALKIR on 10.03.2022.
//

import UIKit
import CoreLocation

class ViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
   
    private var location: CLLocation = CLLocation(latitude: 41.015137, longitude: 28.979530) {
        didSet {
            fetchWeather()
        }
    }
    var weather: WeatherModel? {
        didSet {
            bind?()
        }
    }
    let locationManager = CLLocationManager()
    override init() {
        super.init()
        locationManager.delegate = self
        checkLocationController()
        
    }
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
        String(format: "%.1f", temperatureAsKelvin.kelvinToCelcius) + "° C"
    }
    var bind: (() -> Void)?
    // MARK: - Requests
    func fetchWeather() {
        NetworkController.fetchWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude) { weather in
            self.weather = weather
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }
        DispatchQueue.main.async {
         self.location = latestLocation
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func checkLocationController() {
        locationManager.requestLocation()
    }
}
