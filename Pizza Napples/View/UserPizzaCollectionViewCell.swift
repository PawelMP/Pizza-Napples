//
//  UserPizzaCollectionViewCell.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 11/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class UserPizzaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    class var cellIdentifier: String {
        return "ReusableUserPizzaCell"
    }
    
    class var nibName: String {
        return "UserPizzaCollectionViewCell"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true
    }

}
