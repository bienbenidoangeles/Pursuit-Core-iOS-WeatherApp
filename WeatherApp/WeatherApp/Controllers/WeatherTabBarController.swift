//
//  WeatherTabBarController.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class WeatherTabBarController: UITabBarController {
    let dataPersistance = DataPersistence<Photo>(filename: "SavedWeatherData.plist")
    
    lazy var mainViewController:MainWeatherViewController = {
        let mainVC = MainWeatherViewController()
        mainVC.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return mainVC
    }()
    
    lazy var favViewController:FavoritesViewController = {
        let favVC = FavoritesViewController()
        favVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        return favVC
    }()
    
    lazy var detailViewController:DetailViewController = {
        let detailVC = DetailViewController()
        return detailVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controllers = [mainViewController, favViewController]
        viewControllers = controllers.map{UINavigationController(rootViewController: $0)}
        favViewController.dataPersistance = dataPersistance
        detailViewController.dataPersistance = dataPersistance
    }
    
}
