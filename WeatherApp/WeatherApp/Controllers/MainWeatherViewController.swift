//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class MainWeatherViewController: UIViewController {
    
    var dataPersistance:DataPersistence<Weather>?
    
    let mainView = MainView()
    
    var weatherWeeklyForecast:Weather?{
        didSet{
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    var locationName:String?{
        didSet{
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationController?.title = "Search"
        mainView.collectionView.register(UINib(nibName: "WeatherDayCell", bundle: nil), forCellWithReuseIdentifier: "weatherDayCell")
        delegatesAndDataSources()
        loadData(for: "10463")
    }
    
    func delegatesAndDataSources(){
        mainView.textField.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    func updateUI(){
        mainView.weatherForecastLocationLabel.text = "Weather for \(locationName ?? "N/A")"
    }
    
    func loadData(for zipcode: String){
        ZipCodeHelper.getLatLong(fromZipCode: zipcode) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let coordinate):
                let coordinatePos:(Double, Double) = (coordinate.lat, coordinate.long)
                self.locationName = coordinate.placeName
                WeatherHelper.getWeather(from: coordinatePos) { (result) in
                    switch result{
                    case .failure(let appError):
                        print(appError)
                    case .success(let weather):
                        self.weatherWeeklyForecast = weather
                        dump(weather)
                    }
                }
            }
        }
    }
}

extension MainWeatherViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.4 // 95% of width of device
        return CGSize(width: itemWidth, height: itemWidth*2)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
}

extension MainWeatherViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherWeeklyForecast?.daily.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: "weatherDayCell", for: indexPath) as? WeatherCollectViewCell else { fatalError("failed to downcast to WeatherDayCell. Check resuse ID") }
        let weatherForDay = (weatherWeeklyForecast?.daily.data[indexPath.row])!
        cell.configureCell(for: weatherForDay)
        return cell
    }
}

extension MainWeatherViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let search = textField.text else {
            return false
        }
        loadData(for: search)
        return true
    }
}
