//
//  ViewController.swift
//  Weather-App
//
//  Created by Utku Can BALKIR on 9.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    
    //MARK: - Properties
    private let viewModel = ViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchWeather { [weak self] in
            DispatchQueue.main.async {
                self?.setupUI()
               
            }
        }
    }
    //MARK: - UI Configuration
    
    private func setupUI() {
       setupHeader()
       setupSubHeader()
        
    }
    private func setupHeader() {
        temperatureLabel.text = viewModel.temperatureString
        locationLabel.text = viewModel.locationString
    }
    
    private func  setupSubHeader() {
        feelsLike.text = viewModel.feelsLikeString
        maxTemperature.text = viewModel.tempMaxString
        minTemperature.text = viewModel.tempMinString
        humidityLabel.text = viewModel.humidityString
        pressureLabel.text = viewModel.pressureString
    }


}

