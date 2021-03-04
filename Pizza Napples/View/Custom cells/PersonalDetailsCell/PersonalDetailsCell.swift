//
//  PersonalDetailsCell.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 22/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class PersonalDetailsCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    class var cellIdentifier: String {
        return K.PersonalDetailsCell.cellIdentifier
    }
    
    class var nibName: String {
        return K.PersonalDetailsCell.cellNibName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Setup cell with data
    func setupCell (with item: PersonalDetailsBrain, for indexPath: IndexPath) {
        descriptionLabel.text = item.details[indexPath.row].description
        textField.text = item.details[indexPath.row].userData
    }
    
}
