//
//  UsersPizzasCollectionViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 11/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class UsersPizzasCollectionViewController: UICollectionViewController, UINavigationControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "usersPizzasToAddNewPhoto", sender: self)
        //photosManager.presentAlert(viewController: self)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //if let flowLayout = collectionView?.collectionViewLayout as? //UICollectionViewFlowLayout {
        //  flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        //}
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(.init(nibName: UserPizzaCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: UserPizzaCollectionViewCell.cellIdentifier)
        
        if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            collectionViewLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
            collectionViewLayout.minimumLineSpacing = 5
            collectionViewLayout.minimumInteritemSpacing = 5
            //collectionViewLayout.itemSize = CGSize(width: (self.collectionView.frame.width)/3, height: (self.collectionView.frame.width)/3)
        }
        // Do any additional setup after loading the view.
    }
    
    /*override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
     
     if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
     let itemWidth = view.bounds.width / 3.0
     let itemHeight = layout.itemSize.height
     layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
     layout.invalidateLayout()
     }
     }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserPizzaCollectionViewCell.cellIdentifier, for: indexPath) as? UserPizzaCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Configure the cell
        cell.textLabel.text = "LOL"
        //cell.backgroundColor = UIColor.red
        return cell
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
     return UIEdgeInsets.zero
     }*/
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

extension UsersPizzasCollectionViewController: UICollectionViewDelegateFlowLayout {
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     //return CGSize(width: 150, height: 150)
     //return CGSize(width: collectionView.frame.width, height: UserPizzaCollectionViewCell.)
     //return CGSize(width: self.view.frame.width / 3 - 100 , height: collectionView.frame.size.height - 100)
     
     //return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height - 100)
     let yourWidth = collectionView.bounds.width/3.0
     let yourHeight = yourWidth
     return CGSize(width: yourWidth, height: yourHeight)
     }*/
    
}
