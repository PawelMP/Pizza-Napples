//
//  FirestoreManager.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 07/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

protocol FirestoreManagerDelegate: class {
    func readData(retrievedData: DoughProperties)
}

//Firestore manager class
struct FirestoreManager {
    static var shared = FirestoreManager()
    
    let db = Firestore.firestore()
    
    weak var delegate: FirestoreManagerDelegate?
    
    private init () {
    }
    
    //Save given dough properties to firestore
    func saveDoughToFirestore(calculatorBrain: CalculatorBrain?, viewController: UIViewController?) {
        if let user = Auth.auth().currentUser?.email, let doughProportions = calculatorBrain?.doughProportions, let doughGrowth = calculatorBrain?.doughGrowth {
            
            let doughProperties = DoughProperties(ballsAmount: doughProportions[0].amount, ballWeight: doughProportions[1].amount, hydration: doughProportions[2].amount, salt: doughProportions[3].amount, fat: doughProportions[4].amount, totalTime: doughGrowth[0].amount, fridgeTime: doughGrowth[1].amount, temperature: doughGrowth[2].amount)
            
            db.collection(K.Firestore.usersDough).document(user).setData(doughProperties.dictionary) { (error) in
                if let e = error {
                    print(e.localizedDescription)
                }
                else {
                    viewController?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    //Read dough properties from firestore
    func readDoughFromFirestore() {
        
        if let user = Auth.auth().currentUser?.email {
            
            db.collection(K.Firestore.usersDough).document(user).getDocument { (document, error) in
                
                if let e = error {
                    print(e.localizedDescription)
                }
                else {
                    
                    let result = Result {
                          try document?.data(as: DoughProperties.self)
                        }
                        switch result {
                        case .success(let doughProperties):
                            if let dough = doughProperties {
                                // A `DoughProperties` value was successfully initialized from the DocumentSnapshot.
                                //print("Dough: \(dough)")
                                delegate?.readData(retrievedData: dough)
                                
                            } else {
                                // A nil value was successfully initialized from the DocumentSnapshot,
                                // or the DocumentSnapshot was nil.
                                //delegate?.emptyData()
                            }
                        case .failure(let error):
                            // A `DoughProperties` value could not be initialized from the DocumentSnapshot.
                            print(error.localizedDescription)
                        }
                }
            }
        }
    }
    
}
