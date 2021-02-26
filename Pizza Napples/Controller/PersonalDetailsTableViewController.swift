//
//  PersonalDetailsTableViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 23/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class PersonalDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveChangesButton: UIButton!
    
    private var personalDetailsBrain = PersonalDetailsBrain()
    private var currentTextField: UITextField?
    //private var oldEmail: String?
    
    // MARK: - View controller lifecycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupTableView()
        //Save current user's username
        //oldEmail = personalDetailsBrain.details[1].userData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView setup
    
    //Setup tableview
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = K.Design.Color.Beige
        
        //Turn off delays of touch down gestures
        tableView.delaysContentTouches = false
        
        //Register custom cell
        tableView.register(UINib(nibName: PersonalDetailsCell.nibName, bundle: nil), forCellReuseIdentifier: PersonalDetailsCell.cellIdentifier)
    }
    
    //MARK: - UI action methods
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveChangesButtonPressed(_ sender: UIButton) {
        backButton.isEnabled = false
        
        if let currentTextField = currentTextField {
            currentTextField.resignFirstResponder()
        }
        
        //Update user display name
        FirebaseManager.shared.changeUserDisplayName(to: personalDetailsBrain.details[0].userData, viewController: self, completionHandler: { success in
            if success {
                
                //Update username in user pizza colletion
                FirestoreManager.shared.changeUsernameInUserPizza()
                
                self.personalDetailsBrain = PersonalDetailsBrain()
                self.tableView.reloadData()
                
                let alert = TextAlert()
                alert.createTextAlert(title: K.Content.Success, text: K.Content.ProfileUpdateSuccess, viewController: self)
            }
            
            self.backButton.isEnabled = true
        })
        
    }
}
// MARK: - Table view data source
extension PersonalDetailsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

//MARK: - Textfield delegate
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


