//
//  PizzaDetailsViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 19/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class PizzaDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    var pizzaItem = UserPizzaItem()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupContent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Back button pressed
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Setup view content
    func setupContent() {
        
        //Set navigation bar title
        navigationItem.title = K.author + (pizzaItem.username ?? K.noData)
        
        //Set description
        textLabel.text = pizzaItem.description ?? K.noData
        
        //Set image
        StorageManager.shared.setImageToView(with: pizzaItem, to: imageView)
    }

}
