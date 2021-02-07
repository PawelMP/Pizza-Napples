//
//  TestTableViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 03/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

protocol DoughTableViewControllerDelegate {
  func checkValues()
}

class DoughTableViewController: UITableViewController {
    
    var calculatorBrain = CalculatorBrain()
    var delegate: DoughTableViewControllerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        calculatorBrain.setupTableView(tableView: tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return calculatorBrain.getSections()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       calculatorBrain.getName(for: section)
   }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculatorBrain.getRowsForSections(for: section)
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoughCell.cellIdentifier, for: indexPath) as? DoughCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: calculatorBrain, for: indexPath)

        cell.textField.addTarget(self, action: #selector(textFieldEditingEvents(textField:)), for: .allEditingEvents)
        
        cell.textField.delegate = self

        return cell
    }
    
    @objc func textFieldEditingEvents(textField: UITextField) {
        guard let cell = textField.findParentTableViewCell(),
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        calculatorBrain.saveAmount(with: Int(textField.text!), indexPath: indexPath)
        
        if let value = textField.text {
            calculatorBrain.checkAmount(with: Int(value), for: indexPath, cell: cell as! DoughCell)
        }
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        guard let cell = textField.findParentTableViewCell(),
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        if let value = textField.text {
            calculatorBrain.checkAmount(with: Int(value), for: indexPath, cell: cell as! DoughCell)
        }
    }
    

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       let header = view as! UITableViewHeaderFooterView
       calculatorBrain.configureHeaderView(for: header)
   }
   
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       calculatorBrain.configureHeaderHeight()
   }

}
//MARK: - Textfield delegate
extension DoughTableViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let cell = textField.findParentTableViewCell() as? DoughCell ,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        calculatorBrain.saveAmount(with: Int(textField.text!), indexPath: indexPath)

        if let value = textField.text {
            calculatorBrain.checkAmount(with: Int(value), for: indexPath, cell: cell)
            cell.setupCell(with: calculatorBrain, for: indexPath)
            
            tableView.reloadRows(at: [indexPath], with: .none)
            if indexPath == [1,0] {
                tableView.reloadRows(at: [[1,1]], with: .none)
            }
        }
        delegate?.checkValues()
    }
}
