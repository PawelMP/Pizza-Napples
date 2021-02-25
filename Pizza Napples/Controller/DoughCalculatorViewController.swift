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
    
    private let doughIngredients = DoughEquations()
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Hide navigation bar title
        self.tabBarController?.navigationItem.title = ""
        //Hide "add" button"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        
        addViewItems()
        
        //Set FirestoreManager delegate and read data from firestore
        FirestoreManager.shared.delegate = self
        FirestoreManager.shared.readDoughFromFirestore()
    }
    
    //MARK: - View controller custom methods
    
    //Create view items
    func addViewItems() {
        //Add bar button item
        let userSettingsButton = UIBarButtonItem(image: K.Design.Image.PersonCircle, style: .plain, target: self, action: #selector(userSettingsButtonPressed(_:)))

        self.tabBarController?.navigationItem.leftBarButtonItem = userSettingsButton
    }
    
    //Set label with given text
    func setLabel(with text: String, postfix: String , data dictionary: [String:Any], label: UILabel){
        label.alpha = 1
        label.text = (dictionary[text]! as AnyObject).description + postfix
    }
    
    //MARK: - UI action methods
    
    //Action for "Add" bar button
    @objc func userSettingsButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.Segues.ToUserSettings, sender: self)
    }

}

//MARK: - Firestore Manager Delegate

extension DoughCalculatorViewController: FirestoreManagerDelegate {

    func readData(retrievedData: DoughProperties) {
        
        //Calculate ingredients
        let readyData = doughIngredients.getIngredients(doughProperties: retrievedData)
        
        //Set labels with data
        setLabel(with: K.Content.DoughEquations.Flour, postfix: K.Content.Gram, data: readyData, label: flourLabel)
        setLabel(with: K.Content.DoughEquations.Water, postfix: K.Content.Gram, data: readyData, label: waterLabel)
        setLabel(with: K.Content.DoughEquations.Yeast, postfix: K.Content.Gram, data: readyData, label: yeastLabel)
        setLabel(with: K.Content.DoughEquations.Salt, postfix: K.Content.Gram, data: readyData, label: saltLabel)
        setLabel(with: K.Content.DoughEquations.Fat, postfix: K.Content.Gram, data: readyData, label: fatLabel)
        setLabel(with: K.Content.DoughEquations.BallWeight, postfix: K.Content.Gram, data: readyData, label: ballWeightLabel)
        setLabel(with: K.Content.DoughEquations.Portions, postfix: K.Content.Blank, data: readyData, label: portionsLabel)
        setLabel(with: K.Content.DoughEquations.Hydration, postfix: K.Content.Percent, data: readyData, label: hydrationLabel)
        setLabel(with: K.Content.DoughEquations.RoomTime, postfix: K.Content.Hour, data: readyData, label: roomLabel)
        setLabel(with: K.Content.DoughEquations.FridgeTime, postfix: K.Content.Hour, data: readyData, label: fridgeLabel)
        
        modifyButton.setTitle(K.modifyProportionsButtonName, for: .normal)
        mainStackView.isHidden = false
    }
    
}
