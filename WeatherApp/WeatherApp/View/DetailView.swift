//
//  DetailView.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    lazy var cityDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Headline", size: label.font.pointSize)
        label.textAlignment = .center
        label.text = "Weather Forecast"
        return label
    }()
    
    lazy var cityImageView: UIImageView = {
        let cityImage = UIImageView()
        return cityImage
    }()
    
    lazy var cityDayDetailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Subhead", size: label.font.pointSize)
        label.textAlignment = .center
        label.text = "Detail Weather"
        return label
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
        setUpCityLabelConstrainsts()
        setUpImageViewConstrainsts()
        setUpCityDetailLabelConstrainsts()
    }
    
    private func setUpCityLabelConstrainsts(){
        addSubview(cityDayLabel)
        cityDayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityDayLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            cityDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityDayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cityDayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cityDayLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func setUpImageViewConstrainsts(){
        addSubview(cityImageView)
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityImageView.topAnchor.constraint(equalTo: cityDayLabel.bottomAnchor, constant: 8),
            cityImageView.widthAnchor.constraint(equalTo: widthAnchor),
            cityImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            cityImageView.centerXAnchor.constraint(equalTo: cityDayLabel.centerXAnchor)
        ])
    }
    
    private func setUpCityDetailLabelConstrainsts(){
        addSubview(cityDayDetailLabel)
        cityDayDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityDayDetailLabel.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 8),
            cityDayDetailLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            cityDayDetailLabel.centerXAnchor.constraint(equalTo: cityDayLabel.centerXAnchor),
            cityDayDetailLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 8)
        ])
    }
}
