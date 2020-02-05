//
//  ShowAlert+ViewController.swift
//  WeatherApp
//
//  Created by Bienbenido Angeles on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlert(title:String, message: String, completion: ((UIAlertAction) -> Void)? = nil){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertVC.addAction(okButton)
        present(alertVC, animated: true, completion: nil)
    }
}
