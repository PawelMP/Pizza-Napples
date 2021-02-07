//
//  DoughCalculatorViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 16/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class DoughCalculatorViewController: UIViewController {//UITableViewController {
    
    private var calculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var calculateButton: UIButton!
    //var tableView = UITableView()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //setupTableView()
        super.viewWillAppear(true)
        calculatorBrain.setupTableView(tableView: tableView)
    }
    
    /*private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.90, alpha: 1.00)
        
        
        //Stop the table view headers from floating
        let dummyViewHeight = CGFloat(40)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        
        //Register custom cell
        tableView.register(UINib(nibName: DoughCell.cellNibName, bundle: nil), forCellReuseIdentifier: DoughCell.cellIdentifier)
    }*/
    
    @IBAction func xButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table view data source
extension DoughCalculatorViewController: UITableViewDataSource, UITableViewDelegate {

     func numberOfSections(in tableView: UITableView) -> Int {
        calculatorBrain.getSections()
    }
    
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        calculatorBrain.getName(for: section)
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calculatorBrain.getRowsForSections(for: section)
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoughCell.cellIdentifier, for: indexPath) as? DoughCell else {
            return UITableViewCell()
        }
        
        
        cell.setupCell(with: calculatorBrain, for: indexPath)
        
        //cell.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        //cell.textField.addTarget(self, action: #selector(textFieldDidEnd(textField:)), for: .editingDidEnd)
        
        cell.textField.delegate = self

        return cell
    }

    @objc func textFieldDidEnd(textField : UITextField){
        guard let cell = textField.findParentTableViewCell (),
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        if let value = textField.text {
            //calculatorBrain.saveAmount(with: Int(value), indexPath: indexPath)
            calculatorBrain.checkAmount(with: Int(value), for: indexPath, cell: cell as! DoughCell)
            //calculatorBrain.enableButton(for: calculateButton)
        }
    }
    
    
    @objc func textFieldDidChange(textField : UITextField){
        guard let cell = textField.findParentTableViewCell (),
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        if let value = textField.text {
            //calculatorBrain.saveAmount(with: Int(value), indexPath: indexPath)
            calculatorBrain.checkAmount(with: Int(value), for: indexPath, cell: cell as! DoughCell)
            //calculatorBrain.enableButton(for: calculateButton)
        }
    }
    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        calculatorBrain.configureHeaderView(for: header)
    }
    
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        calculatorBrain.configureHeaderHeight()
    }
    
    /*
    private func tableView(_ tableView: UITableView, didEndDisplaying cell: DoughCell, forRowAt indexPath: IndexPath) {
        
        //let value = Int(cell.textField.text!)
        //calculatorBrain.saveAmount(with: value, indexPath: indexPath)
        //cell.textField.text = nil
        print("enddisplay")
        
       //textFieldShouldEndEditing(cell.textField)
        //textFieldDidEndEditing(cell.textField)
        //calculatorBrain.checkValue(with: cell.textField.text, for: indexPath, cell: cell)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath) as! DoughCell
        //let value = Int(cell.textField.text!)
        //calculatorBrain.saveAmount(with: value, indexPath: indexPath)
        //cell.textField.text = nil
        print("deselectrow")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath)
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DoughCalculatorViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let cell = textField.findParentTableViewCell (),
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        //print("begin editing")
        //print(indexPath)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        /*if textField.text?.isEmpty == true {
            return
        }*/
        print("did end editing")
        guard let cell = textField.findParentTableViewCell (),
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        print(indexPath)
        print(textField.text)
        if let value = textField.text {
            //calculatorBrain.saveAmount(with: Int(value), indexPath: indexPath)
            calculatorBrain.checkAmount(with: Int(value), for: indexPath, cell: cell as! DoughCell)
            //calculatorBrain.enableButton(for: calculateButton)
            print(value)
        }
        /*if textField.text?.isEmpty == true {
            print("empyty")
            return
        }
        
        guard let cell = textField.findParentTableViewCell (),
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let value = Int(textField.text!)
        calculatorBrain.saveAmount(with: value, indexPath: indexPath)
        print("end eiditng")*/
        
        
        
        
        
        
        //calculatorBrain.checkValue(with: textField.text, for: indexPath, cell: cell as! DoughCell)
        
        //calculatorBrain.enableButton(for: calculateButton)
        
        
        //calculatorBrain.test(text: textField.text!, indexPath: indexPath)
        //calculatorBrain.doughProportions[indexPath.row].amount = Int(textField.text!)
        
        /*
        let result = calculatorBrain.checkValue(for: calculatorBrain, with: textField.text, for: indexPath, cell: cell as! DoughCell)
        
        if result {
            calculateButton.isEnabled = true
            calculateButton.alpha = 1
        } else {
            calculateButton.isEnabled = false
            calculateButton.alpha = 0.6
        }*/
    }
}
