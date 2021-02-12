//
//  Constants.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 20/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import Foundation

struct K {
    //static let doneText = "Done"
    static let futura = "Futura"
    static let pizzaNapplesName = "🍕 Pizza Napples 🍕"
    static let modifyProportionsButtonName = " Modify proportions "
    
    struct CalculatorBrain {
        static let doughProportions = "Dough proportions"
        static let growthTime = "Growth time"
        static let empty = ""
        static let totalGrowthTime = "Total growth time [h]"
    }
    
    struct Firebase {
        static let registerToApp = "RegisterToApp"
        static let loginToApp = "LoginToApp"
    }
    
    struct Firestore {
        static let usersDough = "users dough"
    }
    
    struct TextAlert {
        static let error = "Error"
        static let ok = "Ok"
    }
    
    struct DoughEquations {
        static let flour = "flour"
        static let water = "water"
        static let yeast = "yeast"
        static let salt = "salt"
        static let fat = "fat"
        static let ballWeight = "ball weight"
        static let portions = "portions"
        static let hydration = "hydration"
        static let roomTime = "room"
        static let fridgeTime = "fridge"
    }
    
    struct DoughCell {
        static let cellIdentifier = "ReusableDoughCell"
        static let cellNibName = "DoughCell"
    }
    
    struct postfixes {
        static let gram = "g"
        static let hour = "h"
        static let percent = "%"
    }
}
