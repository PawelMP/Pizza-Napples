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
    @IBOutlet weak var imageView: UIImageView!
    //@IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    class var cellIdentifier: String {
        return "ReusableUserPizzaCell"
    }
    
    class var nibName: String {
        return "UserPizzaCollectionViewCell"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true
        //imageView.autoresizingMask.insert(.flexibleHeight)
        //imageView.autoresizingMask.insert(.flexibleWidth)
        
        //textLabel.autoresizingMask.insert(.flexibleHeight)
        //textLabel.autoresizingMask.insert(.flexibleWidth)
        /*self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true
        self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true
        self.contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true*/
        
        /*mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3-7.5).isActive = true*/
        //self.autoresizesSubviews = true
        
    }

}
