//
//  LoginViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 15/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        FirebaseManager.shared.loginUser(email: emailTextField.text, password: passwordTextField.text, viewController: self)
    }

}
