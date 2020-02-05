//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence
import ImageKit

class DetailViewController: UIViewController {
    
    var dataPersistance:DataPersistence<Weather>?
    
    private var detailView = DetailView()
    var passedWeatherLocation: String?
    var passedWeatherDataObj: DataForDay?
    
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addBarButtonItems()
        updateUI()
    }
    
    private func addBarButtonItems(){
        let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    @objc
    private func saveButtonTapped(){
        //dataPersistance?.delegate = self
    }
    
    private func updateUI(){
        guard let weatherLocation = passedWeatherLocation else {
            fatalError("Weather Location was not passed check didSelectRowAt delegate func")
        }
        
        guard let weatherObjForDay = passedWeatherDataObj else {
            fatalError("DailyWeather Obj was not passed")
        }
        PhotoAPIClient.getPhotos(with: weatherLocation) { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.detailView.cityImageView.image = UIImage(named: weatherObjForDay.icon)
                }
            case .success(let photo):
                DispatchQueue.main.async {
                    self.detailView.cityImageView.getImage(with: photo.largeImageURL) { (result) in
                        switch result{
                        case .failure:
                            self.detailView.cityImageView.image = UIImage(named: weatherObjForDay.icon)
                        case .success(let image):
                            DispatchQueue.main.async {
                                self.detailView.cityImageView.image = image
                            }
                        }
                    }
                }
                
            }
        }
        detailView.cityDayLabel.text = "Weather forecast for \(weatherLocation) on \(weatherObjForDay.sunsetTime.convertDate())"
        detailView.cityDayDetailLabel.text = "\(weatherObjForDay.summary)\nHigh: \(Int(weatherObjForDay.temperatureHigh)) deg F\nLow: \(Int(weatherObjForDay.temperatureLow)) deg F\nSunrise:\(weatherObjForDay.sunriseTime.convertTime())\nSunset:\(weatherObjForDay.sunsetTime.convertTime())\nWindspeed: \(Int(weatherObjForDay.windSpeed)) MPH\nPrecipitation Probabilty: \(weatherObjForDay.precipProbability*100) %"
    }
}

extension DetailViewController: DataPersistenceDelegate{
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        return
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        return
    }
}

extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
