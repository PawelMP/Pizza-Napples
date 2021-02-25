//
//  ChangePasswordViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 23/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - UI action methods
    
    @IBAction func changePasswordButtonPressed(_ sender: UIButton) {
        
        //Is any textfield is empty
        if newPasswordTextField.text?.isEmpty == true || confirmPasswordTextField.text?.isEmpty == true {
            let alert = TextAlert()
            alert.createTextAlert(title: K.Content.Error, text: K.Content.FillMissingField, viewController: self)
            return
        }
        
        //If new passwords do not match
        if newPasswordTextField.text != confirmPasswordTextField.text {
            let alert = TextAlert()
            alert.createTextAlert(title: K.Content.Error, text: K.Content.PasswordsDoNotMatch, viewController: self)
            return
        }
        
        //Change password
        FirebaseManager.shared.changeUserPassword(to: newPasswordTextField.text, viewController: self)
        
    }
    
    //Go back button pressed
    @IBAction func xButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
