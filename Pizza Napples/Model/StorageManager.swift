//
//  StorageManager.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 15/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit
import Firebase

struct StorageManager {
    static let shared = StorageManager()
    
    private init() {
        
    }
    
    /*typealias CompletionHandler = (_ success:String) -> String
    
    let handler: ([String]) -> Void = { (array) in
     print("Done working, \(array)")
    }*/
    
    typealias Result = String
    
    func test (image: UIImage, completionHandler: @escaping (Result) -> Void) {
        
        let uuid = UUID.init()
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let imagesReference = storageReference.child("images/\(uuid).png")
        
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            return
        }
        // Upload the file to the path "images/rivers.jpg"
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
                print(downloadURL.absoluteURL)
                completionHandler(downloadURL.absoluteString)
          }
        }
    }
    
}
