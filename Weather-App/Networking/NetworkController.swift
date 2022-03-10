//
//  NetworkController.swift
//  Weather-App
//
//  Created by Utku Can BALKIR on 10.03.2022.
//

import Foundation

struct NetworkController {

    private static var baseURL: String  = "api.openweathermap.org"
    private static let appid: String = "18aa3d000da3bb3028619eacf9be8b1b"
    
    enum Endpoint {
        case cityId(path: String =  "/data/2.5/weather", id:Int)
        
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = baseURL
            components.path = path
            components.queryItems = queryItems
            
            return components.url
        }
        
        private var path: String {
            switch self {
            case .cityId(let path, _):
                return path
            }
        }
       private var  queryItems: [URLQueryItem]{
           var queryItems = [URLQueryItem]()
            switch self {
            case .cityId(_, let id):
                queryItems.append(URLQueryItem(name: "id", value: String(id)))
            }
            
           queryItems.append(URLQueryItem(name: "appid", value: appid ))
        return queryItems
        }
    }
    
    static func fetchWeather(for cityId: Int, _ completion: @escaping((WeatherModel) -> Void)) {
        if let url = Endpoint.cityId(id:cityId).url {
            URLSession.shared.dataTask(with: url)
                {(data, response, error) in
                    if let error = error {
                        print("An error occured.", error)
                    }
                    if let data = data {
                        
                        guard let weather = try? JSONDecoder().decode(WeatherModel.self, from: data) else {return}
                        completion(weather)
                
                    }}.resume()
        
        }
    }
}
