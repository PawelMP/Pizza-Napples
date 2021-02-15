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
    
    var photosManager = PhotosManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosManager.imagePicker.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        photosManager.presentAlert(viewController: self)
        // Your action
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func OKButtonPressed(_ sender: UIBarButtonItem) {
        print("OK")
        if let image = imageView.image {
            StorageManager.shared.test(image: image)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewCollectionViewDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] {
            imageView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.90, alpha: 1.00)
            imageView.image = image as? UIImage
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}