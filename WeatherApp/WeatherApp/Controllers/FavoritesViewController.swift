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
    
    var dataPersistance:DataPersistence<Photo>!
    
    let favView = FavoritesView()
    
    var favoritedPhotos = [Photo](){
        didSet{
            favView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = favView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        registerCells()
        delegateAndDataSources()
        loadData()
    }
    
    private func registerCells(){
        favView.tableView.register(FavoritesCell.self, forCellReuseIdentifier: "FavoritesCell")
    }
    
    func delegateAndDataSources(){
        favView.tableView.dataSource = self
        dataPersistance?.delegate = self
    }
    
    func loadData(){
        do{
            favoritedPhotos = try dataPersistance.loadItems()
        } catch{
            showAlert(title: "Loading Error", message: "\(error)")
        }
    }

}

extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favView.tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as? FavoritesCell else {
            fatalError("failed to downcast to cell")
        }
        
        let favoritedPhoto = favoritedPhotos[indexPath.row]
        
        cell.configureCell(for: favoritedPhoto)
        return cell
    }
    
    
}

extension FavoritesViewController: DataPersistenceDelegate{
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadData()
        favView.tableView.reloadData()
    }

    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        favView.tableView.reloadData()
    }
}
