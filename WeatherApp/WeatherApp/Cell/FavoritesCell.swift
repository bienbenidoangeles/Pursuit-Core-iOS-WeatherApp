//
//  FavoritesCell.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    lazy var cityImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configureCell(for photo: Photo){
        cityImageView.getImage(with: photo.largeImageURL) { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.cityImageView.image = UIImage(systemName: "photo")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.cityImageView.image = image.resizeImage(to: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.35)
                }
            }
        }
    }
    
    private func commonInit(){
        addImageViewConstrainsts()
    }
    
    func addImageViewConstrainsts(){
        addSubview(cityImageView)
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cityImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cityImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
