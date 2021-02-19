//
//  FirebaseManager.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 27/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase

//Firebase manager singleton
struct FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() {
    }
    
    //Register new user to firebase
    func registerUser(email: String?, password: String?, viewController: UIViewController) {
        if let givenEmail = email, let givenPassword = password {
            Auth.auth().createUser(withEmail: givenEmail, password: givenPassword) { authResult, error in
                
                if let err = error {
                    let alert = TextAlert()
                    alert.CreateAlert(text: err.localizedDescription, viewController: viewController)
                }
                else {
                    viewController.performSegue(withIdentifier: K.segues.registerToApp, sender: viewController)
                }
            }
        }
    }
    
    //Login existing user to firebase
    func loginUser(email: String?, password: String?, viewController: UIViewController) {
        
        if let givenEmail = email, let givenPassword = password {
            Auth.auth().signIn(withEmail: givenEmail, password: givenPassword) { authResult, error in
                
                if let err = error {
                    let alert = TextAlert()
                    alert.CreateAlert(text: err.localizedDescription, viewController: viewController)
                    
                }
                else {
                    viewController.performSegue(withIdentifier: K.segues.loginToApp, sender: viewController)
                }
            }
        }
        
    }
    
    //Logout current user from firebase
    func logoutUser (viewController: UIViewController) {
        do {
            try Auth.auth().signOut()
            viewController.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            let alert = TextAlert()
            alert.CreateAlert(text: signOutError.localizedDescription, viewController: viewController)
        }
    }
    
}
