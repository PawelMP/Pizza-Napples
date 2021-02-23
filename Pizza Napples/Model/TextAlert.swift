//
//  TextAlert.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 16/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

struct TextAlert {
    
    //Create simple text alert
    func createTextAlert(title: String, text: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: K.TextAlert.ok, style: .default, handler: { (UIAlertAction) in
            //if alert is created in ForgotPasswordViewController dismiss it after clicking OK
            if let forgotPasswordVC = viewController as? ForgotPasswordViewController {
                forgotPasswordVC.dismiss(animated: true, completion: nil)
            }
        }))
        viewController.present(alert, animated: true)
    }
    
}
