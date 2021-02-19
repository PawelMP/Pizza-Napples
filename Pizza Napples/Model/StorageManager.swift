//
//  StorageManager.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 15/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase

//Storage manager singleton
struct StorageManager {
    static let shared = StorageManager()
    
    private init() {
        
    }
    
    typealias Result = String
    
    //Upload image to Firebase Storage
    func uploadImage (image: UIImage, completionHandler: @escaping (Result) -> Void) {
        
        let uuid = UUID.init()
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let imagesReference = storageReference.child(K.Storage.images + K.Storage.slash + "\(uuid)" + K.Storage.dot + K.Storage.png)
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        // Upload the file to the path "images/\(uuid).jpg"
        let uploadTask = imagesReference.putData(imageData, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
            imagesReference.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
                completionHandler(downloadURL.absoluteString)
          }
        }
    }
    
}
