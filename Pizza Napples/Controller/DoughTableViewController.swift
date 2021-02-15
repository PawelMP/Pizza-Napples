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
    
    //Set delegate to pass data between to parent view controller
    var delegate: DoughTableViewControllerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Setup table view
        calculatorBrain.setupTableView(tableView: tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
    // MARK: - Table view data source
extension DoughTableViewController {
    
    //Numbers of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return calculatorBrain.getSections()
    }
    
    //Title for sections headers
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       calculatorBrain.getName(for: section)
   }

    //Number of row in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculatorBrain.getRowsForSections(for: section)
    }

    
    //Setup cell for row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Dequeue DoughCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoughCell.cellIdentifier, for: indexPath) as? DoughCell else {
            return UITableViewCell()
        }
        //Setup cell with data
        cell.setupCell(with: calculatorBrain, for: indexPath)

        //Check if any editing event ocured on cell's textfield
        cell.textField.addTarget(self, action: #selector(textFieldEditingEvents(textField:)), for: .allEditingEvents)
        
        //Set cell's textfield delegate
        cell.textField.delegate = self

        return cell
    }
    
    //Configure headerview
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       let header = view as! UITableViewHeaderFooterView
       calculatorBrain.configureHeaderView(for: header)
   }
   
   //Configure header height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       calculatorBrain.configureHeaderHeight()
   }

}
//MARK: - Textfield delegate and methods
extension DoughTableViewController: UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //Get indexPath based on which text field ended editing
        guard let cell = textField.findParentTableViewCell() as? DoughCell ,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        //Save value from text field
        calculatorBrain.saveAmount(with: Int(textField.text!), indexPath: indexPath)

        if let value = textField.text {
            //Check if value is correct
            calculatorBrain.checkAmount(with: Int(value), for: indexPath, cell: cell)
            //Setup cell with new value
            cell.setupCell(with: calculatorBrain, for: indexPath)
            
            //Reload changed rows
            tableView.reloadRows(at: [indexPath], with: .none)
            
            //If editing ended on "total time" also reload "fridge time"
            if indexPath == [1,0] {
                tableView.reloadRows(at: [[1,1]], with: .none)
            }
        }
        delegate?.checkValues()
    }
    
    
    //Handle any editing events ocurred on text field
    @objc func textFieldEditingEvents(textField: UITextField) {
        
        //Get indexPath based on which text field ended editing
        guard let cell = textField.findParentTableViewCell(),
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        //Save value from text field
        calculatorBrain.saveAmount(with: Int(textField.text!), indexPath: indexPath)
        
        //Check if value is correct
        if let value = textField.text {
            calculatorBrain.checkAmount(with: Int(value), for: indexPath, cell: cell as! DoughCell)
        }
    }
    
}
