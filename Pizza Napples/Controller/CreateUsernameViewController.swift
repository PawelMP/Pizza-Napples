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
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - UI action methods
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        //If textfield is empty create alert and return
        if usernameTextField.text?.isEmpty == true {
            let alert = TextAlert()
            alert.createTextAlert(title: K.Content.Error, text: K.Content.TypeUsername, viewController: self)
            return
        }
        //Set user display name
        else {
            FirebaseManager.shared.changeUserDisplayName(to: usernameTextField.text, viewController: self, completionHandler: nil)
        }
    }

}
