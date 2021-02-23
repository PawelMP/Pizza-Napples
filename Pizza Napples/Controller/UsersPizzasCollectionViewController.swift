//
//  UsersPizzasCollectionViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 11/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

var pizzas: [UserPizzaItem] = []

class UsersPizzasCollectionViewController: UICollectionViewController, UINavigationControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.title = K.usersPizzas
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.hidesBackButton = true
        addViewItems()
        
    }
    
    //Create view items
    func addViewItems() {
        //Add bar button item
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
    }
    
    //Action for "Add" bar button
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.segues.usersPizzasToAddNewPhoto, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Read users pizza data from firestore
        FirestoreManager.shared.readUserPizzaFromFirestore(collectionView: collectionView)
        
        // Register cell classes
        self.collectionView!.register(.init(nibName: UserPizzaCell.nibName, bundle: nil), forCellWithReuseIdentifier: UserPizzaCell.cellIdentifier)
        
        //Configure collection view layout
        if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            //Set section insets
            collectionViewLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
            //Set spacing
            collectionViewLayout.minimumLineSpacing = 5
            collectionViewLayout.minimumInteritemSpacing = 5

        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Get navigation controller
        if let destinationNavigationController = segue.destination as? UINavigationController, segue.identifier == K.segues.toPizzaDetails{
            
            //Get target controller - PizzaDetailsViewController
            if let targetController = destinationNavigationController.topViewController as? PizzaDetailsViewController {
                
                //Get indexPath for selected cell
                if let indexPath = collectionView.indexPathsForSelectedItems {
                    
                    //Set pizzaitem with data
                    targetController.pizzaItem = pizzas[indexPath[0].row]
                }
            }
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    //Set number of items in section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pizzas.count
    }
    
    //Setup cell for item
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Dequeue UserPizzaCell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserPizzaCell.cellIdentifier, for: indexPath) as? UserPizzaCell else {
            return UICollectionViewCell()
        }
        
        // Setup cell with data
        cell.setupCell(for: indexPath)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    //Handle item selection
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.segues.toPizzaDetails, sender: self)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

//MARK: - Collection view flow layout delegate

extension UsersPizzasCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    //Set size from item at
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Set width/height to make squares and fit 3 cells in one row
        let width  = (view.frame.width/3-7.5)
        return CGSize(width: width, height: width)
    }
    
}
