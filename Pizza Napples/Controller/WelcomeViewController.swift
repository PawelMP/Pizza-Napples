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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "🍕 Pizza Napples 🍕"
    }

}

