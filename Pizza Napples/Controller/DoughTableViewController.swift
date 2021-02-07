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
        //tableView.estimatedRowHeight = 10
        //tableView.scr
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return calculatorBrain.getSections()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       calculatorBrain.getName(for: section)
   }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return calculatorBrain.getRowsForSections(for: section)
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoughCell.cellIdentifier, for: indexPath) as? DoughCell else {
            return UITableViewCell()
        }
        print("setup")
        cell.setupCell(with: calculatorBrain, for: indexPath)
        
        /*if indexPath.section == 0 {
            calculatorBrain.doughProportions[indexPath.row].cell = cell
        }
        else if indexPath.section == 1 {
            calculatorBrain.doughGrowth[indexPath.row].cell = cell
        }*/
        
        //cell.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        //cell.textField.addTarget(self, action: #selector(textFieldDidEnd(textField:)), for: .editingDidEnd)
        //cell.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        cell.textField.addTarget(self, action: #selector(textFieldTest(textField:)), for: .allEditingEvents)
        
        cell.textField.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("will display cell")
    }
    
    @objc func textFieldTest(textField: UITextField) {
        guard let cell = textField.findParentTableViewCell(),
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        /*
        
        if textField.text?.isEmpty == true {
            calculatorBrain.saveAmount(with: Int(textField.text!), indexPath: indexPath)
            return
        }*/
        
        calculatorBrain.saveAmount(with: Int(textField.text!), indexPath: indexPath)
        if let value = textField.text {
            //calculatorBrain.saveAmount(with: Int(value), indexPath: indexPath)
            calculatorBrain.checkAmount(with: Int(value), for: indexPath, cell: cell as! DoughCell)
            
            //calculatorBrain.enableButton(for: calculateButton)
        }
        print("all editing events")
        
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        guard let cell = textField.findParentTableViewCell(),
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        
        if let value = textField.text {
            //calculatorBrain.saveAmount(with: Int(value), indexPath: indexPath)
            calculatorBrain.checkAmount(with: Int(value), for: indexPath, cell: cell as! DoughCell)
            
            //calculatorBrain.enableButton(for: calculateButton)
        }
    }
    

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       let header = view as! UITableViewHeaderFooterView
       calculatorBrain.configureHeaderView(for: header)
   }
   
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       calculatorBrain.configureHeaderHeight()
   }
        
    private func tableView(_ tableView: UITableView, didEndDisplaying cell: DoughCell, forRowAt indexPath: IndexPath) {
        
        //let value = Int(cell.textField.text!)
        //calculatorBrain.saveAmount(with: value, indexPath: indexPath)
        //cell.textField.text = nil
        print("enddisplay")
        
       //textFieldShouldEndEditing(cell.textField)
        //textFieldDidEndEditing(cell.textField)
        //calculatorBrain.checkValue(with: cell.textField.text, for: indexPath, cell: cell)
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: - Textfield delegate
extension DoughTableViewController: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrolled")
        //self.tableView.visibleCells
    }
    
    
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
