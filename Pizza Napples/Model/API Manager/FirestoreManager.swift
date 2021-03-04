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
    
    weak var delegate: FirestoreManagerDelegate?
    
    private init () {
    }
    
    //Save given dough properties to firestore
    func saveDoughToFirestore(calculatorBrain: CalculatorBrain?, viewController: UIViewController?) {
        if let user = K.API.AUTH_REF.currentUser?.email, let doughProportions = calculatorBrain?.doughProportions, let doughGrowth = calculatorBrain?.doughGrowth {
            
            let doughProperties = DoughProperties(ballsAmount: doughProportions[0].amount, ballWeight: doughProportions[1].amount, hydration: doughProportions[2].amount, salt: doughProportions[3].amount, fat: doughProportions[4].amount, totalTime: doughGrowth[0].amount, fridgeTime: doughGrowth[1].amount, temperature: doughGrowth[2].amount)
            
            K.API.USERS_DOUGH_DB_REF.document(user).setData(doughProperties.dictionary) { (error) in
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
        
        if let user = K.API.AUTH_REF.currentUser?.email {
            
            //Get document based on current user
            K.API.USERS_DOUGH_DB_REF.document(user).getDocument { (document, error) in
                
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
                        case .failure(let err):
                            // A `DoughProperties` value could not be initialized from the DocumentSnapshot.
                            print(err.localizedDescription)
                        }
                }
            }
        }
    }
    
    //Save given user pizza data to firestore
    func saveUserPizzaToFirestore(description: String, imageURL: String) {
        
        //Create unique ID
        let uuid = UUID().uuidString
        
        if let username = K.API.AUTH_REF.currentUser?.displayName, let email = K.API.AUTH_REF
            .currentUser?.email{
            
            let userPizzaPropertiesData = UserPizzaPropertiesData(downloadURL: imageURL, description: description, username: username, date: Date().timeIntervalSince1970, email: email)
            
            K.API.USERS_PIZZA_DB_REF.document(uuid).setData(userPizzaPropertiesData.dictionary) { (error) in
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
        K.API.USERS_PIZZA_DB_REF.order(by: K.Content.Date).limit(to: 100).addSnapshotListener { (querySnapshot, error) in
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
    
    //Change username in documents when user changes username in app settings (based on email)
    func changeUsernameInUserPizza () {
        if let email = K.API.AUTH_REF.currentUser?.email {
            K.API.USERS_PIZZA_DB_REF.whereField(K.Content.EmailLowercase, isEqualTo: email).getDocuments { (querySnapshot, error) in
                if let err = error {
                    print(err.localizedDescription)
                }
                else {
                    for document in querySnapshot!.documents {
                        K.API.USERS_PIZZA_DB_REF.document(document.documentID).updateData([K.Content.UsernameLowercase : FirebaseManager.shared.getUserDisplayName()])
                    }
                }
            }
        }
    }
    
}
