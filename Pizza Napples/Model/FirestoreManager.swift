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

struct FirestoreManager {
    static let shared = FirestoreManager()
    
    let db = Firestore.firestore()
    
    private init () {
    }
    
    func saveDoughToFirestore(calculatorBrain: CalculatorBrain?, viewController: UIViewController?) {
        if let user = Auth.auth().currentUser?.email, let doughProportions = calculatorBrain?.doughProportions, let doughGrowth = calculatorBrain?.doughGrowth {
            
            let doughProperties = DoughProperties(ballsAmount: doughProportions[0].amount, ballWeight: doughProportions[1].amount, hydration: doughProportions[2].amount, salt: doughProportions[3].amount, fat: doughProportions[4].amount, totalTime: doughGrowth[0].amount, fridgeTime: doughGrowth[1].amount, temperature: doughGrowth[2].amount)
            
            db.collection("users dough").document(user).setData(doughProperties.dictionary) { (error) in
                if let e = error {
                    print("Error writing dough to Firestore: \(e)")
                }
                else {
                    print("sucessfully wrote data")
                    viewController?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func readDoughFromFirestore() {
        if let user = Auth.auth().currentUser?.email {
            
            db.collection("users dough").document(user).getDocument { (document, error) in
                
                if let e = error {
                    print("Error reading data from firestore: \(e)")
                }
                else {
                    
                    let result = Result {
                          try document?.data(as: DoughProperties.self)
                        }
                        switch result {
                        case .success(let doughProperties):
                            if let dough = doughProperties {
                                // A `DoughProperties` value was successfully initialized from the DocumentSnapshot.
                                print("Dough: \(dough)")
                            } else {
                                // A nil value was successfully initialized from the DocumentSnapshot,
                                // or the DocumentSnapshot was nil.
                                print("Document does not exist")
                            }
                        case .failure(let error):
                            // A `DoughProperties` value could not be initialized from the DocumentSnapshot.
                            print("Error decoding city: \(error)")
                        }
                }
            }
        }
    }
    
}
