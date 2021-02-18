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
    func readUserPizza(retrievedData: UserPizzaItem)
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
    
    func saveUserPizzaToFirestore(description: String, imageURL: String/*, viewController: UIViewController?*/) {
        
        let uuid = UUID().uuidString
        
        let email: String
        if let word = Auth.auth().currentUser?.email {
            if let index = word.range(of: "@")?.lowerBound {
                let substring = word.prefix(upTo: index)
                email = String(substring)
                
                let userPizzaPropertiesData = UserPizzaPropertiesData(downloadURL: imageURL, description: description, userID: email)
                
                db.collection("users pizza").document(uuid).setData(userPizzaPropertiesData.dictionary) { (error) in
                    if let e = error {
                        print(e.localizedDescription)
                    }
                    else {
                        //viewController?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    /*func readUserPizzaFromFirestore() {
        
        
        db.collection("users pizza").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let result = Result {
                        try document.data(as: UserPizzaPropertiesData.self)
                        }
                        switch result {
                        case .success(let userPizzaProperties):
                            if let userPizza = userPizzaProperties {
                                // A `DoughProperties` value was successfully initialized from the DocumentSnapshot.
                                //print("Dough: \(dough)")
                                //delegate?.readData(retrievedData: dough)
                                var userPizzaItem = UserPizzaItem()
                                userPizzaItem.downloadURL = userPizza.downloadURL
                                userPizzaItem.description = userPizza.description
                                userPizzaItem.userID = userPizza.userID
                                delegate?.readUserPizza(retrievedData: userPizzaItem)
                                //array.append(userPizzaItem)
                                
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
    }*/
    
    func readUserPizzaFromFirestore(collectionView: UICollectionView) {
        
        pizzas = []
        
        db.collection("users pizza").addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                pizzas = []
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    
                    let result = Result {
                        try document.data(as: UserPizzaPropertiesData.self)
                        }
                        switch result {
                        case .success(let userPizzaProperties):
                            if let userPizza = userPizzaProperties {
                                // A `DoughProperties` value was successfully initialized from the DocumentSnapshot.
                                //print("Dough: \(dough)")
                                //delegate?.readData(retrievedData: dough)
                                var userPizzaItem = UserPizzaItem()
                                userPizzaItem.downloadURL = userPizza.downloadURL
                                userPizzaItem.description = userPizza.description
                                userPizzaItem.userID = userPizza.userID
                                pizzas.append(userPizzaItem)
                                collectionView.reloadData()
                                //delegate?.readUserPizza(retrievedData: userPizzaItem)
                                //array.append(userPizzaItem)
                                
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
