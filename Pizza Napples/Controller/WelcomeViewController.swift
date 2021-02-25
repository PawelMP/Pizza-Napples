//
//  ViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 14/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    // MARK: - View controller lifecycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.shared.checkForLoggedUser(viewController: self)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = K.pizzaNapplesName
    }

}

