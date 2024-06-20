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
    
    var weatherManager = WeatherDataManager()
    var searchName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画像設定
        backgroundImageView.image = R.image.background()
        
        weatherManager.delegate = self
        // ナビゲーションバー透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear
        
        //天気API実行
        weatherManager.fetchWeather(searchName)
    }
    
}

//MARK:- View update extension
extension ThirdViewController: WeatherManagerDelegate {
    
    func updateWeather(weatherModel: WeatherModel){
        DispatchQueue.main.sync {
            temperatureLabel.text = weatherModel.temperatureString
            cityName.text = weatherModel.cityName
            self.weatherImageView.image = UIImage(systemName: weatherModel.conditionName)
        }
    }
    
    func failedWithError(error: Error){
        print(error)
    }
}

