//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {
    
    var dataPersistance:DataPersistence<Photo>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
    
    func delegateAndDataSources(){
        dataPersistance?.delegate = self
    }

}

extension FavoritesViewController: DataPersistenceDelegate{
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        //reload tableView
    }

    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        return
    }
}
