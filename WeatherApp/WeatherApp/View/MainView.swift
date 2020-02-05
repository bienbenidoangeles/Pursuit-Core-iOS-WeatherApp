//
//  MainView.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit


class MainView: UIView {
    
    var weatherForecastLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Headline", size: label.font.pointSize)
        label.textAlignment = .center
        label.text = "Weather Forecast"
        return label
    }()
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.itemSize = CGSize(width: 150, height: 300)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Enter a zipcode"
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpLabelConstrainsts()
        setUpCollectionView()
        setUpTextField()
    }
    
    func setUpLabelConstrainsts(){
        addSubview(weatherForecastLocationLabel)
        weatherForecastLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherForecastLocationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            weatherForecastLocationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherForecastLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weatherForecastLocationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setUpCollectionView(){
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: weatherForecastLocationLabel.bottomAnchor, constant: 8),
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            collectionView.centerXAnchor.constraint(equalTo: weatherForecastLocationLabel.centerXAnchor)
        ])
    }
    
    func setUpTextField(){
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
            textField.centerXAnchor.constraint(equalTo: weatherForecastLocationLabel.centerXAnchor)
        ])
    }
}
