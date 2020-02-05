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
    
    var dataPersistance:DataPersistence<Photo>?
    
    private var detailView = DetailView()
    var passedWeatherLocation: String?
    var passedWeatherDataObj: DataForDay?
    var passedPhoto:Photo?
    
    var favoritedPic: Photo?
    
    
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
        
        guard let photoSelected = passedPhoto else{
            return
        }
        favoritedPic = Photo(largeImageURL: photoSelected.largeImageURL, webformatHeight: photoSelected.webformatHeight, webformatWidth: photoSelected.webformatHeight, previewURL: photoSelected.previewURL, favorited: true)
        
    }
    
    private func updateUI(){
        guard let weatherLocation = passedWeatherLocation else {
            fatalError("Weather Location was not passed check didSelectRowAt delegate func")
        }
        
        guard let weatherObjForDay = passedWeatherDataObj else {
            fatalError("DailyWeather Obj was not passed")
        }
        
        guard let validPhoto = passedPhoto else {
            fatalError("Photo obj was not passed")
        }
        
        detailView.cityDayLabel.text = "Weather forecast for \(weatherLocation) on \(weatherObjForDay.sunsetTime.convertDate())"
        detailView.cityDayDetailLabel.text = "\(weatherObjForDay.summary)\nHigh: \(Int(weatherObjForDay.temperatureHigh)) deg F\nLow: \(Int(weatherObjForDay.temperatureLow)) deg F\nSunrise:\(weatherObjForDay.sunriseTime.convertTime())\nSunset:\(weatherObjForDay.sunsetTime.convertTime())\nWindspeed: \(Int(weatherObjForDay.windSpeed)) MPH\nPrecipitation Probabilty: \(weatherObjForDay.precipProbability*100) %"
        detailView.cityImageView.getImage(with: validPhoto.largeImageURL) { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.detailView.cityImageView.image = UIImage(systemName: "photo")
                }
            case .success(let image):
                self.detailView.cityImageView.image = image
            }
        }
    }
}

//extension DetailViewController: DataPersistenceDelegate{
//    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
//
//        //favoritedPic is of type Photo?
//        guard let validPic = favoritedPic else { fatalError("Favorited Pic was not created") }
//        do{
//             try persistenceHelper.createItem(validPic)
//        } catch {
//            showAlert(title: "Data Persist Erro", message: "\(error)")
//        }
//    }
//
//    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
//        return
//    }
//}

extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
