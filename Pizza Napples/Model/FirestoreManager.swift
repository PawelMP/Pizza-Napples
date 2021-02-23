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

//Delegate methods
protocol FirestoreManagerDelegate: class {
    func readData(retrievedData: DoughProperties)
}

//Firestore manager singleton
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
                if let err = error {
                    print(err.localizedDescription)
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
            
            //Get document based on current user
            db.collection(K.Firestore.usersDough).document(user).getDocument { (document, error) in
                
                if let err = error {
                    print(err.localizedDescription)
                }
                else {
                    
                    let result = Result {
                        //Decode data as DoughProperties
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
    
    //Save given user pizza data to firestore
    func saveUserPizzaToFirestore(description: String, imageURL: String) {
        
        //Create unique ID
        let uuid = UUID().uuidString
        
        //let email: String
        if let username = Auth.auth().currentUser?.displayName {
            
            let userPizzaPropertiesData = UserPizzaPropertiesData(downloadURL: imageURL, description: description, username: username, date: Date().timeIntervalSince1970)
            
            db.collection(K.Firestore.usersPizza).document(uuid).setData(userPizzaPropertiesData.dictionary) { (error) in
                if let err = error {
                    print(err.localizedDescription)
                }
                else {
                }
            }
        }
    }
    
    //Read all users pizza data from firestore
    func readUserPizzaFromFirestore(collectionView: UICollectionView) {
        
        //Clear pizzas array
        pizzas = []
        
        //Read document and listen for changes in a collection
        db.collection(K.Firestore.usersPizza).order(by: K.Firestore.date).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                //Clear pizzas array
                pizzas = []
                
                //Read all data but reversed to show newest files at the top of collection view
                for document in querySnapshot!.documents.reversed() {
                    
                    let result = Result {
                        //Decode data as UserPizzaPropertiesData
                        try document.data(as: UserPizzaPropertiesData.self)
                        }
                        switch result {
                        case .success(let userPizzaProperties):
                            if let userPizza = userPizzaProperties {
                                // A `UserPizzaPropertiesData` value was successfully initialized from the DocumentSnapshot.
                                var userPizzaItem = UserPizzaItem()
                                userPizzaItem.downloadURL = userPizza.downloadURL
                                userPizzaItem.description = userPizza.description
                                userPizzaItem.username = userPizza.username
                                pizzas.append(userPizzaItem)
                                collectionView.reloadData()
                                
                            } else {
                                // A nil value was successfully initialized from the DocumentSnapshot,
                                // or the DocumentSnapshot was nil.
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
