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
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var modifyButton: UIButton!
    
    let doughIngredients = DoughEquations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Hide navigation bar title
        self.tabBarController?.navigationItem.title = ""
        //Hide "add" button"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        
        //Set FirestoreManager delegate and read data from firestore
        FirestoreManager.shared.delegate = self
        FirestoreManager.shared.readDoughFromFirestore()
    }
    
    //Set label with given text
    func setLabel(with text: String, postfix: String , data dictionary: [String:Any], label: UILabel){
        label.alpha = 1
        label.text = (dictionary[text]! as AnyObject).description + postfix
    }

}
//MARK: - Firestore Manager Delegate
extension DoughCalculatorViewController: FirestoreManagerDelegate {

    func readData(retrievedData: DoughProperties) {
        
        //Calculate ingredients
        let readyData = doughIngredients.getIngredients(doughProperties: retrievedData)
        
        setLabel(with: K.DoughEquations.flour, postfix: K.postfixes.gram, data: readyData, label: flourLabel)
        setLabel(with: K.DoughEquations.water, postfix: K.postfixes.gram, data: readyData, label: waterLabel)
        setLabel(with: K.DoughEquations.yeast, postfix: K.postfixes.gram, data: readyData, label: yeastLabel)
        setLabel(with: K.DoughEquations.salt, postfix: K.postfixes.gram, data: readyData, label: saltLabel)
        setLabel(with: K.DoughEquations.fat, postfix: K.postfixes.gram, data: readyData, label: fatLabel)
        setLabel(with: K.DoughEquations.ballWeight, postfix: K.postfixes.gram, data: readyData, label: ballWeightLabel)
        setLabel(with: K.DoughEquations.portions, postfix: K.postfixes.gram, data: readyData, label: portionsLabel)
        setLabel(with: K.DoughEquations.hydration, postfix: K.postfixes.percent, data: readyData, label: hydrationLabel)
        setLabel(with: K.DoughEquations.roomTime, postfix: K.postfixes.hour, data: readyData, label: roomLabel)
        setLabel(with: K.DoughEquations.fridgeTime, postfix: K.postfixes.hour, data: readyData, label: fridgeLabel)
        
        modifyButton.setTitle(K.modifyProportionsButtonName, for: .normal)
        mainStackView.isHidden = false
    }
    
    
}
