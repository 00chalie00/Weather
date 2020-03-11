//
//  ManageWeather.swift
//  Clima
//
//  Created by formathead on 2020/02/28.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol ManageWeatherDelegate {
    func didupdated(_ weatherModel: WeatherModel)
}

struct ManageWeather {
    
    var delegate: ManageWeatherDelegate?
    
    
    func getURL(_ url: String) {
        let cityName = url
        let key = "e55a720a086ffbb6d1fdd011f4f2e175"
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(key)&units=metric"
        print(url)
        requestQuery(url)
    }
    
    func requestQuery(_ url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let sessionTask = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Data receve Fail")
                    return
                }
                
                if let responseData = data {
                    if let parseData = self.parseJSON(responseData) {
                        self.delegate?.didupdated(parseData)
                        
                    }
                }
            }
            sessionTask.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let parse = try decoder.decode(WeatherData.self, from: data)
            let name = parse.name
            let temp = parse.main.temp
            let weatherID = parse.weatherID[0].id
            let weatherModel = WeatherModel(name: name, temp: temp, weatherID: weatherID)
            
            return weatherModel
            
        } catch {
            print(error)
            
            return nil
        }
    }
    
    func getData(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
   
    
}
