//
//  RegisterViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 15/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Register user to firebase
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        FirebaseManager.shared.registerUser(email: emailTextField.text, password: passwordTextField.text, viewController: self)
    }

}
