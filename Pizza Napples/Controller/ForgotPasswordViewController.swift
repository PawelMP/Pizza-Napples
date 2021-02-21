//
//  ForgotPasswordViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 21/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Forgot password button pressed
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        if let email = textField.text {
            //Send email with password reset link
            FirebaseManager.shared.sendPasswordResetEmail(with: email, viewController: self)
        }
        else {
            //Create error alert
            let alert = TextAlert()
            alert.createTextAlert(text: K.pleaseTypeEmail, viewController: self)
        }
    }

}
