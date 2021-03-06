//
//  UserPizzaCollectionViewCell.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 11/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class UserPizzaCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    class var cellIdentifier: String {
        return K.UserPizzaCell.cellIdentifier
    }
    
    class var nibName: String {
        return K.UserPizzaCell.cellNibName
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Set image view constraint to match cell constraints (screen width/3-7.5)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true
        
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    //Setup cell with pizzas data
    func setupCell(for indexPath: IndexPath) {
        let item = pizzas[indexPath.row]
        StorageManager.shared.setImageToView(with: item, to: imageView)
    }

}
