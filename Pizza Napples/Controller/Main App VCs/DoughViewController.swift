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
    
    private var doughTableViewController: DoughTableViewController?
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Assign children view controller and its delegate
        doughTableViewController = self.children[0] as? DoughTableViewController
        doughTableViewController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            //Call "viewWillAppear" from parent View Controller
            if let firstVC = presentingViewController as? DoughCalculatorViewController {
                DispatchQueue.main.async {
                    firstVC.viewWillAppear(true)
                }
            }
        }
    
    //MARK: - UI action methods
    
    //"Quit" button pressed
    @IBAction func xButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Calculate button pressed
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        calculateButton.isEnabled = false
        
        //Save dough properties to firestore
        FirestoreManager.shared.saveDoughToFirestore(calculatorBrain: doughTableViewController?.calculatorBrain, viewController: doughTableViewController)
        
    }
    
    //Enable "calculate" button
    func enableButton () {
        calculateButton.isEnabled = true
        calculateButton.alpha = 1
    }
    
    //Disable "calcualte" button
    func disableButton () {
        calculateButton.isEnabled = false
        calculateButton.alpha = 0.6
    }
    
}
//MARK: - DoughTableViewController Delegate
extension DoughViewController: DoughTableViewControllerDelegate {
    
    //Check if all values are correct and enable/disable button
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
