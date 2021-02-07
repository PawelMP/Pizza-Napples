//
//  DoughViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 03/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class DoughViewController: UIViewController {
    @IBOutlet weak var calculateButton: UIButton!
    var doughTableViewController: DoughTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        doughTableViewController = self.children[0] as? DoughTableViewController
        doughTableViewController?.delegate = self
    }
    
    @IBAction func xButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        FirestoreManager.shared.saveDoughToFirestore(calculatorBrain: doughTableViewController?.calculatorBrain, viewController: doughTableViewController)
        
        FirestoreManager.shared.readDoughFromFirestore()
    }
    
    func enableButton () {
        calculateButton.isEnabled = true
        calculateButton.alpha = 1
    }
    
    func disableButton () {
        calculateButton.isEnabled = false
        calculateButton.alpha = 0.6
    }
    
}

extension DoughViewController: DoughTableViewControllerDelegate {
    
    func checkValues() {
        if let calculator = doughTableViewController?.calculatorBrain {
            if calculator.checkAllElements() {
                enableButton()
            }
            else {
                disableButton()
            }
        }
    }
    
}
