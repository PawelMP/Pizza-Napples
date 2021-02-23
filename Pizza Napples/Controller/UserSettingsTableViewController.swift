//
//  UserSettingsTableViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 21/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class UserSettingsTableViewController: UITableViewController {
    
    let userSettingsBrain = UserSettingsBrain()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Setup table view
        setupTableView()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Back button pressed
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    //Setup tableview
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.97, green: 0.96, blue: 0.92, alpha: 1.00)
        
        //Stop the table view headers from floating
        let dummyViewHeight = CGFloat(40)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: dummyViewHeight))
        tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        
        //Register custom cell
        tableView.register(UINib(nibName: UserSettingsCell.nibName, bundle: nil), forCellReuseIdentifier: UserSettingsCell.cellIdentifier)
    }
    
    // MARK: - Table view data source

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
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Create headerView and label
        let headerView = UIView()
        let label: UILabel = UILabel()
        
        //Set label properties
        label.textColor = UIColor(red: 0.25, green: 0.27, blue: 0.29, alpha: 1.00)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: K.markerFeltThin, size: 25)!
        label.text = "Welcome " + FirebaseManager.shared.getUserDisplayName()
        label.adjustsFontSizeToFitWidth = true
        headerView.addSubview(label)
        
        //Set label contraints
        label.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true

        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.size.height / 10
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        userSettingsBrain.performAction(for: indexPath, viewController: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
