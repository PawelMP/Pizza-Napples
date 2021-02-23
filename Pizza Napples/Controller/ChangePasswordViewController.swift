//
//  ChangePasswordViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 23/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changePasswordButtonPressed(_ sender: UIButton) {
        
        //Is any textfield is empty
        if newPasswordTextField.text?.isEmpty == true || confirmPasswordTextField.text?.isEmpty == true {
            let alert = TextAlert()
            alert.createTextAlert(title: K.TextAlert.error, text: "Please fill missing fields", viewController: self)
            return
        }
        
        //If new passwords do not match
        if newPasswordTextField.text != confirmPasswordTextField.text {
            let alert = TextAlert()
            alert.createTextAlert(title: K.TextAlert.error, text: "Passwords do not match", viewController: self)
            return
        }
        
        //Change password
        FirebaseManager.shared.changeUserPassword(to: newPasswordTextField.text, viewController: self)
        
    }
    
    @IBAction func xButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
