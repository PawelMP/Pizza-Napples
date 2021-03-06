//
//  NewCollectionViewDataViewController.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 15/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

class NewCollectionViewDataViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var OKButton: UIBarButtonItem!
    
    private var photosManager = PhotosManager()
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItemTitle()
        
        photosManager.imagePicker.delegate = self
        
        createTapRecognizer()
    }
    
    //MARK: - ViewController custom methods
    
    func setNavigationItemTitle() {
        self.navigationItem.title = K.Content.DisplayName + FirebaseManager.shared.getUserDisplayName()
    }
    
    func createTapRecognizer() {
        //Create tap recognizer to handle image tapping
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: - UI action methods
    
    //If image is tapped
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        photosManager.presentAlert(viewController: self)
    }
    
    //Cancel button is pressed
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //OK button is pressed
    @IBAction func OKButtonPressed(_ sender: UIBarButtonItem) {
        
        //If text is empty create alert
        if descriptionTextView.text.isEmpty == true {
            let alert = TextAlert()
            alert.createTextAlert(title: K.Content.Error, text: K.Content.WriteDescription, viewController: self)
            return
        }
        
        //If description != nil upload image to storage and save data to firestore
        if let image = imageView.image, let description = descriptionTextView.text {
            StorageManager.shared.uploadImage(image: image, completionHandler: { result in
                FirestoreManager.shared.saveUserPizzaToFirestore(description: description, imageURL: result)
            })
        }
        self.dismiss(animated: true, completion: nil)
    }

}

//MARK: - Image picker delegate
extension NewCollectionViewDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //If image was succesfully picked do
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Get image from info
        if let image = info[UIImagePickerController.InfoKey(rawValue: K.Content.PickerControllerEditedImage)] {

            //Set image in view and enable button
            imageView.image = image as? UIImage
            OKButton.isEnabled = true
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

