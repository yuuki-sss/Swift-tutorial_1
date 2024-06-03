//
//  ThirdViewController.swift
//  Clima
//
//  Created by 徳永勇希 on 2024/06/02.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var searchName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画像設定
        backgroundImageView.image = UIImage(named: "background")
        
        // ナビゲーションバー透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear
        
        // 天気API実行
        let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=4e415e4ab2aaed09e04d8419beedee19&units=metric"
        let completeURL = "\(baseURL)&q=\(searchName)"
        guard let url = URL(string: completeURL) else { return }
        APIService.shared.getRequest(url: url, type: WeatherData.self) { (response) in
            print(response.name)
            DispatchQueue.main.sync {
                let weatherModel = WeatherModel(cityName: response.name, conditionId: response.weather[0].id, temperature: response.main.temp)
                self.cityName.text = weatherModel.cityName
                self.temperatureLabel.text = weatherModel.temperatureString + "℃"
                self.weatherImageView.image = UIImage(systemName: weatherModel.conditionName)
            }
            
        } errorHandler: { (error) in
            print(error)
        }
        
    }
    
}
