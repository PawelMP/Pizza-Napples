//
//  PersonalDetailsTableViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 23/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase

class PersonalDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveChangesButton: UIButton!
    
    var personalDetailsBrain = PersonalDetailsBrain()
    var currentTextField: UITextField?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Setup tableview
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.97, green: 0.96, blue: 0.92, alpha: 1.00)
        
        //Turn off delays of touch down gestures
        tableView.delaysContentTouches = false
        
        //Register custom cell
        tableView.register(UINib(nibName: PersonalDetailsCell.nibName, bundle: nil), forCellReuseIdentifier: PersonalDetailsCell.cellIdentifier)
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveChangesButtonPressed(_ sender: UIButton) {
        backButton.isEnabled = false
        
        if let currentTextField = currentTextField {
                    currentTextField.resignFirstResponder()
                }
        
        FirebaseManager.shared.changeUserDisplayName(to: personalDetailsBrain.details[0].userData, viewController: self)
        FirebaseManager.shared.changeUserEmail(to: personalDetailsBrain.details[1].userData, viewController: self, completionHandler: { success in
            if success {
                self.personalDetailsBrain = PersonalDetailsBrain()
                self.tableView.reloadData()
                let alert = TextAlert()
                alert.createTextAlert(title: K.TextAlert.success, text: "Succesfully updated profile", viewController: self)
            }
            self.backButton.isEnabled = true
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personalDetailsBrain.details.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeue DoughCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDetailsCell.cellIdentifier, for: indexPath) as? PersonalDetailsCell else {
            return UITableViewCell()
        }

        //Setup cell with data
        cell.setupCell(with: personalDetailsBrain, for: indexPath)
        
        //Set cell's textfield delegate
        cell.textField.delegate = self

        return cell
    }

}

//MARK: - Textfield delegate and methods
extension PersonalDetailsTableViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Get indexPath based on which text field ended editing
        guard let cell = textField.findParentTableViewCell() as? PersonalDetailsCell ,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        if textField.text?.isEmpty == true {
            tableView.reloadData()
            return
        }
        
        if let text = textField.text {
            personalDetailsBrain.details[indexPath.row].userData = text
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


