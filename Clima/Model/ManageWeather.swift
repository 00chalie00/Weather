//
//  ManageWeather.swift
//  Clima
//
//  Created by formathead on 2020/02/28.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

protocol ManageWeatherDelegate {
    func didupdated(_ weatherModel: WeatherModel)
    func receveImage(_ image: UIImage)
}

struct ManageWeather {
    
    var delegate: ManageWeatherDelegate?
    
    
    func getURL(_ url: String) {
        let cityName = url
        let key = "e55a720a086ffbb6d1fdd011f4f2e175"
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(key)&units=metric"

        requestQuery(url)
    }
    
    func updatePosition(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        //https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22
        let key = "e55a720a086ffbb6d1fdd011f4f2e175"
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(key)&units=metric"
        requestQuery(url)
    }
    
    func requestQuery(_ url: String) {
        if let url = URL(string: url) {
            print(url)
            let session = URLSession(configuration: .default)
            let sessionTask = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    
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
            let weatherid = parse.weather[0].id
            
            let weatherModel = WeatherModel(name: name, temp: temp, weatherID: weatherid)
            returnImageData(weatherModel: weatherModel)
            return weatherModel
            
        } catch {
            print(error)
            
            return nil
        }
    }
    
    //Data를 받아 UIImage로 Convert
    func returnImageData(weatherModel: WeatherModel) {
        getData(weatherIDNum: weatherModel.weatherIconName) { (data, response, error) in
            if error != nil {
                print(error as Any)
            }
            if let returnData = data {
                if let image = UIImage(data: returnData) {
                    self.delegate?.receveImage(image)
                }
            }
        }
    }
    
    //URL을 이용하여 Data(png file)을 수신
    func getData(weatherIDNum: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let number = weatherIDNum
        let urlString = "https://openweathermap.org/img/wn/\(number).png"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
    }
}
