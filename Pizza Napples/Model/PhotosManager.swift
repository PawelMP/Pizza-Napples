//
//  PhotosManager.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 15/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

struct PhotosManager {
    
    var imagePicker : UIImagePickerController = UIImagePickerController()
    
    //Create alert and present it
    func presentAlert(viewController: UIViewController) {
        let alert = UIAlertController(title: K.PhotosManager.chooseImage, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: K.PhotosManager.camera, style: .default, handler: { _ in
            self.openCamera(viewController: viewController)
        }))
        
        alert.addAction(UIAlertAction(title: K.PhotosManager.gallery, style: .default, handler: { _ in
            self.openGallery(viewController: viewController)
        }))
        
        alert.addAction(UIAlertAction.init(title: K.PhotosManager.cancel, style: .cancel, handler: nil))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    //Open camera
    func openCamera(viewController: UIViewController)
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            viewController.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: K.PhotosManager.warning, message: K.PhotosManager.noCamera, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: K.PhotosManager.ok, style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    //Open gallery
    func openGallery(viewController: UIViewController)
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            viewController.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: K.PhotosManager.warning, message: K.PhotosManager.noPermissionPhotoLibrary, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: K.PhotosManager.ok, style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
