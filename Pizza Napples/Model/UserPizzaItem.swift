//
//  UserPizzaItem.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 18/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import Foundation

//Struct for holding user pizza data retrieved from firestore
struct UserPizzaItem {
    var downloadURL: String?
    var description: String?
    var username: String?
}
