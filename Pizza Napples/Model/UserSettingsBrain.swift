//
//  UserSettingsBrain.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 22/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase

struct UserSettingsBrain {
    let settings = [UserSettingsItem(description: K.Content.UserSettings.PersonalDetails, image: K.Design.Image.PersonSquare),
                    UserSettingsItem(description: K.Content.UserSettings.ChangePassword, image: K.Design.Image.LockFill),
                    UserSettingsItem(description: K.Content.UserSettings.Logout, image: K.Design.Image.LogoutSymbol)
    ]
    
    //Perfom action based on IndexPath of selected row
    func performAction (for indexPath: IndexPath, viewController: UIViewController) {
        if indexPath.row == 0 {
            viewController.performSegue(withIdentifier: K.Segues.ToPersonalDetails, sender: viewController)
        }
        else if indexPath.row == 1 {
            viewController.performSegue(withIdentifier: K.Segues.ToReauthenticate, sender: viewController)
        }
        else {
            FirebaseManager.shared.logoutUser(viewController: viewController)
        }
    }
}
