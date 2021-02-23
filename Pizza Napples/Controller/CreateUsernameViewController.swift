//
//  CreateUsernameViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 22/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class CreateUsernameViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        //If textfield is empty create alert and return
        if usernameTextField.text?.isEmpty == true {
            let alert = TextAlert()
            alert.createTextAlert(title: K.TextAlert.error, text: K.pleaseTypeUsername, viewController: self)
            return
        }
        //Set user display name
        else {
            FirebaseManager.shared.changeUserDisplayName(to: usernameTextField.text, viewController: self)
        }
    }

}
