//
//  PersonalDetailsBrain.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 22/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

struct PersonalDetailsBrain {
    var details = [PersonalDetailsItem(description: "Username", userData: FirebaseManager.shared.getUserDisplayName()),
        PersonalDetailsItem(description: "E-mail", userData: FirebaseManager.shared.getUserEmail())
    ]
    
}
