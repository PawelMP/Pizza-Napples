//
//  FirebaseManager.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 27/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase

struct FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() {
    }
    
    
    func registerUser(email: String?, password: String?, viewController: UIViewController) {
        if let givenEmail = email, let givenPassword = password {
            Auth.auth().createUser(withEmail: givenEmail, password: givenPassword) { authResult, error in
                
                if let e = error {
                    let alert = TextAlert()
                    alert.CreateAlert(text: e.localizedDescription, topVC: viewController)
                }
                else {
                    viewController.performSegue(withIdentifier: K.Firebase.registerToApp, sender: viewController)
                }
            }
        }
    }
    
    func loginUser(email: String?, password: String?, viewController: UIViewController) {
        
        if let givenEmail = email, let givenPassword = password {
            Auth.auth().signIn(withEmail: givenEmail, password: givenPassword) { authResult, error in
                
                if let e = error {
                    let alert = TextAlert()
                    alert.CreateAlert(text: e.localizedDescription, topVC: viewController)
                    
                }
                else {
                    viewController.performSegue(withIdentifier: K.Firebase.loginToApp, sender: viewController)
                }
            }
        }
        
    }
    
    func logoutUser (viewController: UIViewController) {
        do {
            try Auth.auth().signOut()
            viewController.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            let alert = TextAlert()
            alert.CreateAlert(text: signOutError.localizedDescription, topVC: viewController)
        }
    }
    
}
