//
//  ViewController.swift
//  Weather-App
//
//  Created by Utku Can BALKIR on 9.03.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var dropDownMenu: UIPickerView!
    // MARK: - Properties
    var cities : [City] = [City]()
    private let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropDownMenu()
        viewModel.bind = { [unowned self] in
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
      
    }
    // MARK: - UI Configuration
    private func setupUI() {
       setupHeader()
       setupSubHeader()
    }
    private func setupHeader() {
        temperatureLabel.text = viewModel.temperatureString
        locationLabel.text = viewModel.locationString
    }
    private func setupDropDownMenu() {
        dropDownMenu.delegate = self
        dropDownMenu.dataSource = self
       cities = loadJson()
       cities.shuffle()
       cities = Array(cities[0...10])
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(cities[row].name), \(cities[row].country)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCity = cities[row]
        viewModel.location = CLLocation(latitude: selectedCity.coord.lat, longitude: selectedCity.coord.lon)
    }
    private func setupSubHeader() {
        feelsLike.text = viewModel.feelsLikeString
        maxTemperature.text = viewModel.tempMaxString
        minTemperature.text = viewModel.tempMinString
        humidityLabel.text = viewModel.humidityString
        pressureLabel.text = viewModel.pressureString
    }
    
    func loadJson() -> [City] {
        if let url = Bundle.main.url(forResource: "city.list", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([City].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
}
