//
//  MainView.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit


class MainView: UIView {
    
    var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 400, height: 400)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray
        return collectionView
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
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
        
    }
    
    func setUpCollectionView(){
        
    }
    
    func setUpTextField(){
        
    }
}
