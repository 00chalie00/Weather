//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var weatherIMG: UIImageView!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    
    var manageWeather = ManageWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTxtField.delegate = self
        manageWeather.delegate = self
        
    }
    
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        searchTxtField.endEditing(true)
    }
    
    
}//End of The Class

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    //지정된 텍스트 필드에 대해 편집이 중지되었음을 대리인에게 알립니다.
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityString = searchTxtField.text {
            manageWeather.getURL(cityString)
        }
        searchTxtField.text = ""
    }
    
    //텍스트 필드가 리턴 버튼 누르기를 처리해야하는지 요청합니다.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTxtField.endEditing(true)
        return true
    }
    
    //지정된 텍스트 필드에서 편집을 중지해야하는지 대리인에게 묻습니다.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please Type Something"
            return false
        }
    }
    
    
}

//MARK: - ManageWeatherDelegate

extension WeatherViewController: ManageWeatherDelegate {
    func receveImage(_ image: UIImage) {
        DispatchQueue.main.async {
            //self.weatherIMG.contentMode = .scaleAspectFit
            self.weatherIMG.image = image
        }
    }
    
    func didupdated(_ weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            let rawData = weatherModel
            self.temperatureLbl.text = String(format: "%.1f", rawData.temp)
            self.cityLbl.text = rawData.name
        }
    }
}
