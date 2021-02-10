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
    
    @IBOutlet weak var ballWeightLabel: UILabel!
    @IBOutlet weak var portionsLabel: UILabel!
    @IBOutlet weak var hydrationLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var fridgeLabel: UILabel!
    
    let doughIngredients = DoughEquations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        FirestoreManager.shared.delegate = self
        FirestoreManager.shared.readDoughFromFirestore()
    }

}
//MARK: - Firestore Manager Delegate
extension DoughCalculatorViewController: FirestoreManagerDelegate {
    func readData(retrievedData: DoughProperties) {
        
        let readyData = doughIngredients.getIngredients(doughProperties: retrievedData)
        flourLabel.text = readyData[K.DoughEquations.flour]!.description + K.postfixes.gram
        waterLabel.text = readyData[K.DoughEquations.water]!.description + K.postfixes.gram
        yeastLabel.text = readyData[K.DoughEquations.yeast]!.description + K.postfixes.gram
        saltLabel.text = readyData[K.DoughEquations.salt]!.description + K.postfixes.gram
        fatLabel.text = readyData[K.DoughEquations.fat]!.description + K.postfixes.gram
        ballWeightLabel.text = readyData[K.DoughEquations.ballWeight]!.description + K.postfixes.gram
        portionsLabel.text = readyData[K.DoughEquations.portions]!.description + K.postfixes.gram
        hydrationLabel.text = readyData[K.DoughEquations.hydration]!.description + K.postfixes.percent
        roomLabel.text = readyData[K.DoughEquations.roomTime]!.description + K.postfixes.hour
        fridgeLabel.text = readyData[K.DoughEquations.fridgeTime]!.description + K.postfixes.hour
        
    }
    
    
}
