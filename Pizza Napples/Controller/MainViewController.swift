//
//  MainViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 15/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.shared.checkIfUserHasUsername(viewController: self)
    }

}
