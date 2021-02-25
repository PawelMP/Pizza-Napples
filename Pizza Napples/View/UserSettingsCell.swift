//
//  UserSettingsCell.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 22/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class UserSettingsCell: UITableViewCell {
    
    @IBOutlet weak var descriptionImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    class var cellIdentifier: String {
        return K.UserSettingsCell.cellIdentifier
    }
    
    class var nibName: String {
        return K.UserSettingsCell.cellNibName
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        label.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Setup cell with data
    func setupCell (with item: UserSettingsBrain, for indexPath: IndexPath) {
        label.text = item.settings[indexPath.row].description
        descriptionImage.image = item.settings[indexPath.row].image
    }
    
}
