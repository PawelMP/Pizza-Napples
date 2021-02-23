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
    typealias Result = Bool
    
    private init() {
    }
    
    //Register new user to firebase
    func registerUser(email: String?, password: String?, viewController: UIViewController) {
        if let givenEmail = email, let givenPassword = password {
            Auth.auth().createUser(withEmail: givenEmail, password: givenPassword) { authResult, error in
                
                if let err = error {
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.TextAlert.error, text: err.localizedDescription, viewController: viewController)
                }
                else {
                    //viewController.performSegue(withIdentifier: K.segues.registerToApp, sender: viewController)
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
                    alert.createTextAlert(title: K.TextAlert.error, text: err.localizedDescription, viewController: viewController)
                    
                }
                else {
                    //viewController.performSegue(withIdentifier: K.segues.loginToApp, sender: viewController)
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
            alert.createTextAlert(title: K.TextAlert.error, text: signOutError.localizedDescription, viewController: viewController)
        }
    }
    
    //Send email to the user with password reset link
    func sendPasswordResetEmail (with email: String, viewController: UIViewController) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let err = error {
                let alert = TextAlert()
                alert.createTextAlert(title: K.TextAlert.error, text: err.localizedDescription, viewController: viewController)
            }
            else {
                let alert = TextAlert()
                alert.createTextAlert(title: K.TextAlert.success, text: K.Firebase.passwordResetSent, viewController: viewController)
            }
        }
    }
    
    //Check if user was/just logged in
    func checkForLoggedUser (viewController: UIViewController) {
        Auth.auth().addStateDidChangeListener { [weak viewController] (_, user) in
            if user != nil {
                // user is already logged in go to MainViewController
                viewController?.performSegue(withIdentifier: K.segues.userLoggedToApp, sender: self)
            } else {
                // user is not logged in
            }
        }
    }
    
    //Check if user has username
    func checkIfUserHasUsername (viewController: UIViewController) {
        if let user = Auth.auth().currentUser {
            //If user does not have user name - perform segue 
            if user.displayName == nil {
                viewController.performSegue(withIdentifier: K.segues.toCreateUsername, sender: self)
            }
        }
        
    }
    
    //Change user displayname
    func changeUserDisplayName (to username: String?, viewController: UIViewController) {
        //create change request
        if let name = username {
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            //change user display name
            changeRequest?.displayName = name
            changeRequest?.commitChanges { (error) in
                //if error ocurred
                if let err = error {
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.TextAlert.error, text: err.localizedDescription, viewController: viewController)
                    
                }
                //if there was no error
                else {
                    //if alert is created in PersonalDetailsTableViewController dont dismiss it after click ok
                    if viewController is PersonalDetailsTableViewController {
                    }
                    else {
                        viewController.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    //Change user password
    func changeUserPassword (to password: String?, viewController: UIViewController) {
        if let givenPassword = password {
            Auth.auth().currentUser?.updatePassword(to: givenPassword) { (error) in
                if let err = error {
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.TextAlert.error, text: err.localizedDescription, viewController: viewController)
                }
                else {
                    viewController.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    //Change user email
    func changeUserEmail (to email: String?, viewController: UIViewController, completionHandler: @escaping (Result) -> Void) {
        if let givenEmail = email {
            Auth.auth().currentUser?.updateEmail(to: givenEmail) { (error) in
                if let err = error {
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.TextAlert.error, text: err.localizedDescription, viewController: viewController)
                    completionHandler(false)
                }
                else {
                    completionHandler(true)
                    //viewController.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    //Get user display name
    func getUserDisplayName () -> String {
        if let username = Auth.auth().currentUser?.displayName {
            return username
        }
        else {
            return "No data"
        }
    }
    
    //Get user email
    func getUserEmail () -> String {
        if let email = Auth.auth().currentUser?.email {
            return email
        }
        else {
            return "No data"
        }
    }
    
    //Reauthenticate user to be able to change password
    func reauthenticateUser (email: String?, password: String?, viewController: UIViewController) {
        if let givenEmail = email, let givenPassword = password {
            //var credential: AuthCredential
            let credential = EmailAuthProvider.credential(withEmail: givenEmail, password: givenPassword)
            
            Auth.auth().currentUser?.reauthenticate(with: credential) { (result, error)  in
                if let err = error {
                    // An error happened.
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.TextAlert.error, text: err.localizedDescription, viewController: viewController)
                } else {
                    // User re-authenticated.
                    viewController.performSegue(withIdentifier: K.segues.toPasswordChange, sender: viewController)
                }
            }
        }
    }
    
}
