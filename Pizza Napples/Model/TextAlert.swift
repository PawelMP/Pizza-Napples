//
//  TextAlert.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 16/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

struct TextAlert {
    func CreateAlert(text: String, topVC: UIViewController) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
        }))
        topVC.present(alert, animated: true)
    }
}
