//
//  DoughCell.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 16/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class DoughCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    class var cellIdentifier: String {
         return "ReusableDoughCell"
    }
    
    class var cellNibName: String {
        return "DoughCell"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("reuse!")
        hideError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.adjustsFontSizeToFitWidth = true
        textField.adjustsFontSizeToFitWidth = true
        errorLabel.adjustsFontSizeToFitWidth = true
        //textField.addDoneButtonOnKeyboard()
        //textField.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.90, alpha: 1.00)
        
        //textField.delegate = self
        //textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    /*@objc func textFieldDidChange(textField : UITextField){
       print("changed")
    }*/

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func showError () {
        errorLabel.alpha = 1
        textField.borderColor = UIColor.red
        label.textColor = UIColor.red
    }
    
    func hideError () {
        errorLabel.alpha = 0
        textField.borderColor = UIColor(red: 0.25, green: 0.27, blue: 0.29, alpha: 1.00)
        label.textColor = UIColor(red: 0.25, green: 0.27, blue: 0.29, alpha: 1.00)
    }
    
    func setupCell (with item: CalculatorBrain, for indexPath: IndexPath) {
        if indexPath.section == 0 {
            label.text = item.doughProportions[indexPath.row].description
            textField.placeholder = item.doughProportions[indexPath.row].placeholder
            errorLabel.text = item.doughProportions[indexPath.row].error
            
            //print(item.doughProportions[indexPath.row].amount)
            //print(item.doughProportions[indexPath.row].amount?.description)
            textField.tag = indexPath.row
            if let amount = item.doughProportions[indexPath.row].amount {
                textField.text = amount.description
                
                if item.doughProportions[indexPath.row].isValueCorrect == false {
                    showError()
                }
                else {
                    hideError()
                }
                
            }
            else {
                textField.text = nil
            }
            
            
            /*if let amount = item.doughProportions[indexPath.row].amount {
                textField.text = amount.description
                print("textFIELD:")
                print(amount)
            }
            else {
                textField.text = nil
            }*/
        }
                
        else if indexPath.section == 1 {
            label.text = item.doughGrowth[indexPath.row].description
            textField.placeholder = item.doughGrowth[indexPath.row].placeholder
            errorLabel.text = item.doughGrowth[indexPath.row].error
            
            textField.tag = indexPath.row
            if let amount = item.doughGrowth[indexPath.row].amount {
                textField.text = amount.description
                
                if item.doughGrowth[indexPath.row].isValueCorrect == false {
                    showError()
                }
                else {
                    hideError()
                }
            }
            else {
                textField.text = nil
            }
        }
        //textField.tag = indexPath.row
        //textField.delegate = self
    }
    
}
