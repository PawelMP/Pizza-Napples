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
    let settings = [UserSettingsItem(description: "My personal details", image: UIImage(systemName: "person.crop.square.fill.and.at.rectangle")),
                    UserSettingsItem(description: "Change password", image: UIImage(systemName: "lock.fill")),
                    UserSettingsItem(description: "Logout", image: UIImage(systemName: "arrow.left.square"))
    ]
    
    func performAction (for indexPath: IndexPath, viewController: UIViewController) {
        if indexPath.row == 0 {
            viewController.performSegue(withIdentifier: K.segues.toPersonalDetails, sender: viewController)
        }
        else if indexPath.row == 1 {
            viewController.performSegue(withIdentifier: K.segues.toReauthenticate, sender: viewController)
        }
        else {
            FirebaseManager.shared.logoutUser(viewController: viewController)
        }
    }
}
