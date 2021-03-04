//
//  MainViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 15/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.shared.checkIfUserHasUsername(viewController: self)
    }

}
