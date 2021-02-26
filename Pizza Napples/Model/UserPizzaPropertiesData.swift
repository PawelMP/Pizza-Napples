//
//  UserPizzaPropertiesData.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 17/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

//Struct for sending and receiving users pizza data from firestore
struct UserPizzaPropertiesData: Codable {
    
    let downloadURL: String
    let description: String
    let username: String
    let date: Double
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case downloadURL
        case description
        case username
        case date
        case email
    }
    
    var dictionary: [String: Any] {
            let data = (try? JSONEncoder().encode(self)) ?? Data()
            return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        }
    
}
