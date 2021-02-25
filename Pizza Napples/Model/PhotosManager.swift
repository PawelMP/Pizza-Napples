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
        let alert = UIAlertController(title: K.Content.PhotosManager.ChooseImage, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: K.Content.PhotosManager.Camera, style: .default, handler: { _ in
            self.openCamera(viewController: viewController)
        }))
        
        alert.addAction(UIAlertAction(title: K.Content.PhotosManager.Gallery, style: .default, handler: { _ in
            self.openGallery(viewController: viewController)
        }))
        
        alert.addAction(UIAlertAction.init(title: K.Content.Cancel, style: .cancel, handler: nil))
        
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
            let alert  = UIAlertController(title: K.Content.Warning, message: K.Content.PhotosManager.NoCamera, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: K.Content.OK, style: .default, handler: nil))
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
            let alert  = UIAlertController(title: K.Content.Warning, message: K.Content.PhotosManager.NoPermissionPhotoLibrary, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: K.Content.OK, style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
