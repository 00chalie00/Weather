//
//  ManageWeather.swift
//  Clima
//
//  Created by formathead on 2020/02/28.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct ManageWeather {
    
    func setURL(cityName: String) {
        let apiKey = "e55a720a086ffbb6d1fdd011f4f2e175"
        
        //api.openweathermap.org/data/2.5/weather?q={city name}&appid={your api key}
        let rawURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)"
        print(rawURL)
        requestWeatherData(rawURL)
    }
    
    func requestWeatherData(_ url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let sessionTask = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Data Receve Fail")
                    return
                }
                if let safeData = data {
                    let parsedData = self.parseJSON(data: safeData)
                    print(parsedData)
                }
            }
            sessionTask.resume()
        }
    }
    
    func parseJSON(data: Data) -> String{
        let decoder = JSONDecoder()
        do {
            let decordedData = try decoder.decode(WeatherData.self, from: data)
            print(decordedData)
            let name = decordedData.name
            return name
        } catch {
            let error = "Error"
            return error
        }
        
        
    }
    
}
