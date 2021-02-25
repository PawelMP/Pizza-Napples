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
            K.API.AUTH_REF.createUser(withEmail: givenEmail, password: givenPassword) { authResult, error in
                
                if let err = error {
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.Content.Error, text: err.localizedDescription, viewController: viewController)
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
            K.API.AUTH_REF.signIn(withEmail: givenEmail, password: givenPassword) { authResult, error in
                
                if let err = error {
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.Content.Error, text: err.localizedDescription, viewController: viewController)
                    
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
            try K.API.AUTH_REF.signOut()
            viewController.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            let alert = TextAlert()
            alert.createTextAlert(title: K.Content.Error, text: signOutError.localizedDescription, viewController: viewController)
        }
    }
    
    //Send email to the user with password reset link
    func sendPasswordResetEmail (with email: String, viewController: UIViewController) {
        K.API.AUTH_REF.sendPasswordReset(withEmail: email) { error in
            if let err = error {
                let alert = TextAlert()
                alert.createTextAlert(title: K.Content.Error, text: err.localizedDescription, viewController: viewController)
            }
            else {
                let alert = TextAlert()
                alert.createTextAlert(title: K.Content.Success, text: K.Content.PasswordResetSent, viewController: viewController)
            }
        }
    }
    
    //Check if user was/just logged in
    func checkForLoggedUser (viewController: UIViewController) {
        K.API.AUTH_REF.addStateDidChangeListener { [weak viewController] (_, user) in
            if user != nil {
                // user is already logged in go to MainViewController
                viewController?.performSegue(withIdentifier: K.Segues.UserLoggedToApp, sender: self)
            } else {
                // user is not logged in
            }
        }
    }
    
    //Check if user has username
    func checkIfUserHasUsername (viewController: UIViewController) {
        if let user = K.API.CURRENT_USER_REF {
            //If user does not have user name - perform segue 
            if user.displayName == nil {
                viewController.performSegue(withIdentifier: K.Segues.ToCreateUsername, sender: self)
            }
        }
        
    }
    
    //Change user displayname
    func changeUserDisplayName (to username: String?, viewController: UIViewController, completionHandler: ((Bool) -> Void)?) {
        //create change request
        if let name = username {
            print("change user display name:")
            print(name)
            let changeRequest = K.API.CURRENT_USER_REF?.createProfileChangeRequest()
            //change user display name
            changeRequest?.displayName = name
            changeRequest?.commitChanges { (error) in
                //if error ocurred
                if let err = error {
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.Content.Error, text: err.localizedDescription, viewController: viewController)
                    completionHandler?(false)
                    
                }
                //if there was no error
                else {
                    //if alert is created in PersonalDetailsTableViewController dont dismiss it after click ok
                    if viewController is PersonalDetailsTableViewController {
                    }
                    else {
                        viewController.dismiss(animated: true, completion: nil)
                    }
                    completionHandler?(true)
                }
            }
        }
    }
    
    //Change user password
    func changeUserPassword (to password: String?, viewController: UIViewController) {
        if let givenPassword = password {
            K.API.CURRENT_USER_REF?.updatePassword(to: givenPassword) { (error) in
                if let err = error {
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.Content.Error, text: err.localizedDescription, viewController: viewController)
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
            K.API.CURRENT_USER_REF?.updateEmail(to: givenEmail) { (error) in
                if let err = error {
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.Content.Error, text: err.localizedDescription, viewController: viewController)
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
        if let username = K.API.USER_DISPLAY_NAME {
            print("get suer display name")
            print(username)
            return username
        }
        else {
            return K.Content.NoData
        }
    }
    
    //Get user email
    func getUserEmail () -> String {
        if let email = K.API.USER_EMAIL {
            return email
        }
        else {
            return K.Content.NoData
        }
    }
    
    //Reauthenticate user to be able to change password
    func reauthenticateUser (email: String?, password: String?, viewController: UIViewController) {
        if let givenEmail = email, let givenPassword = password {
            //var credential: AuthCredential
            let credential = EmailAuthProvider.credential(withEmail: givenEmail, password: givenPassword)
            
            K.API.CURRENT_USER_REF?.reauthenticate(with: credential) { (result, error)  in
                if let err = error {
                    // An error happened.
                    let alert = TextAlert()
                    alert.createTextAlert(title: K.Content.Error, text: err.localizedDescription, viewController: viewController)
                } else {
                    // User re-authenticated.
                    viewController.performSegue(withIdentifier: K.Segues.ToPasswordChange, sender: viewController)
                }
            }
        }
    }
    
}
