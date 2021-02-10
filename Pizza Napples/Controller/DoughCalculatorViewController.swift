//
//  DoughCalculatorViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 08/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class DoughCalculatorViewController: UIViewController {
    @IBOutlet weak var flourLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var yeastLabel: UILabel!
    @IBOutlet weak var saltLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    let doughIngredients = DoughEquations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirestoreManager.shared.delegate = self
        
        //FirestoreManager.shared.readDoughFromFirestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        FirestoreManager.shared.delegate = self
        
        FirestoreManager.shared.readDoughFromFirestore()
    }

}

extension DoughCalculatorViewController: FirestoreManagerDelegate {
    func readData(retrievedData: DoughProperties) {
        print(retrievedData)
        
        let array = doughIngredients.getIngredients(doughProperties: retrievedData)
        flourLabel.text = array[1]!.description + "g"
        waterLabel.text = array[2]?.description
        yeastLabel.text = array[3]?.description
        saltLabel.text = array[4]?.description
        fatLabel.text = array[5]?.description
        
    }
    
    
}
