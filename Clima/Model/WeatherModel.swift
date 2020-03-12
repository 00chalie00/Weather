//
//  WeatherModel.swift
//  Clima
//
//  Created by formathead on 2020/03/05.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let name: String
    let temp: Double
    let weatherID: Int
    
    var weatherIconURL: String {
        let iconURL = "http://openweathermap.org/img/wn/\(weatherIconName).png"
        return iconURL
    }
    
    var weatherIconName: String {
        switch weatherID {
        case 200...232:
            return "11d"
        case 300...321:
            return "09d"
        case 500...504:
            return "10d"
        case 511...511:
            return "13d"
        case 520...531:
            return "09d"
        case 600...622:
            return "13d"
        case 701...781:
            return "50d"
        case 800...800:
            return "01d"
        case 801...801:
            return "02d"
        case 802...802:
            return "03d"
        case 803...804:
            return "04d"
        default:
            return "01d"
        }
    }
}

