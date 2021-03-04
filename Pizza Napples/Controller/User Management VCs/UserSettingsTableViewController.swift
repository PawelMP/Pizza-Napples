//
//  UserSettingsTableViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 21/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class UserSettingsTableViewController: UITableViewController {
    
    private let userSettingsBrain = UserSettingsBrain()
    
    // MARK: - View controller lifecycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Setup table view
        setupTableView()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView setup
    
    //Setup tableview
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = K.Design.Color.Beige
        
        //Stop the table view headers from floating
        let dummyViewHeight = CGFloat(40)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: dummyViewHeight))
        tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        
        //Register custom cell
        tableView.register(UINib(nibName: UserSettingsCell.nibName, bundle: nil), forCellReuseIdentifier: UserSettingsCell.cellIdentifier)
    }
    
    //MARK: - UI action methods
    
    //Back button pressed
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table view data source
extension UserSettingsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSettingsBrain.settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Dequeue DoughCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserSettingsCell.cellIdentifier, for: indexPath) as? UserSettingsCell else {
            return UITableViewCell()
        }
        
        //Setup cell with data
        cell.setupCell(with: userSettingsBrain, for: indexPath)
        
        return cell
    }
}
//MARK: - Table view delegate
extension UserSettingsTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Create headerView and label
        let headerView = UIView()
        let label: UILabel = UILabel()
        
        //Set label properties
        label.textColor = K.Design.Color.DarkGrey
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = K.Design.Font.MarkerFeltThin
        label.text = K.Content.UserSettings.Welcome + FirebaseManager.shared.getUserDisplayName()
        label.adjustsFontSizeToFitWidth = true
        headerView.addSubview(label)
        
        //Set label contraints
        label.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return K.Screen.Height / 10
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        userSettingsBrain.performAction(for: indexPath, viewController: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
