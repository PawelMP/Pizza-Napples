//
//  ReauthenticateUserViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 23/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class ReauthenticateUserViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - UI action methods
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reauthenticateButtonPressed(_ sender: UIButton) {
        FirebaseManager.shared.reauthenticateUser(email: emailTextField.text, password: passwordTextField.text, viewController: self)
    }

}
