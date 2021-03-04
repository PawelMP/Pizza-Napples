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
        return K.DoughCell.cellIdentifier
    }
    
    class var cellNibName: String {
        return K.DoughCell.cellNibName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hideError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.adjustsFontSizeToFitWidth = true
        textField.adjustsFontSizeToFitWidth = true
        errorLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //Show error values
    func showError () {
        errorLabel.alpha = 1
        textField.borderColor = K.Design.Color.Red
        label.textColor = K.Design.Color.Red
    }
    
    //Hide error values
    func hideError () {
        errorLabel.alpha = 0
        textField.borderColor = K.Design.Color.DarkGrey
        label.textColor = K.Design.Color.DarkGrey
    }
    
    //Setup dough cell
    func setupCell (with item: CalculatorBrain, for indexPath: IndexPath) {
        if indexPath.section == 0 {
            label.text = item.doughProportions[indexPath.row].description
            textField.placeholder = item.doughProportions[indexPath.row].placeholder
            errorLabel.text = item.doughProportions[indexPath.row].error
            
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
    }
    
}
