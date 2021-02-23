//
//  Constants.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 20/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import Foundation

struct K {

    static let futura = "Futura"
    static let markerFeltThin = "Marker Felt Thin"
    static let pizzaNapplesName = "🍕 Pizza Napples 🍕"
    static let modifyProportionsButtonName = " Modify proportions "
    static let usersPizzas = "Users pizzas"
    static let pleaseWriteDescription = "Please write a description"
    static let pickerControllerEditedImage = "UIImagePickerControllerEditedImage"
    static let noData = "no data"
    static let author = "Author: "
    static let pleaseTypeEmail = "Please type in your e-mail"
    static let pleaseTypeUsername = "Please type in your username"
    
    struct segues {
        static let registerToApp = "registerToApp"
        static let loginToApp = "loginToApp"
        static let usersPizzasToAddNewPhoto = "usersPizzasToAddNewPhoto"
        static let toPizzaDetails = "toPizzaDetails"
        static let userLoggedToApp = "userLoggedToApp"
        static let toCreateUsername = "toCreateUsername"
        static let toUserSettings = "toUserSettings"
        static let toReauthenticate = "toReauthenticate"
        static let toPasswordChange = "toPasswordChange"
        static let toPersonalDetails = "toPersonalDetails"
    }
    
    struct CalculatorBrain {
        static let doughProportions = "Dough proportions"
        static let growthTime = "Growth time"
        static let empty = ""
        static let totalGrowthTime = "Total growth time [h]"
    }
    
    struct Firebase {
        static let passwordResetSent = "Password reset sent to e-mail"
    }
    
    struct Firestore {
        static let usersDough = "users dough"
        static let usersPizza = "users pizza"
        static let at = "@"
        static let date = "date"
    }
    
    struct Storage {
        static let images = "images"
        static let slash = "/"
        static let dot = "."
        static let png = "png"
    }
    
    struct PhotosManager {
        static let chooseImage = "Choose Image"
        static let camera = "Camera"
        static let gallery = "Gallery"
        static let cancel = "Cancel"
        static let warning = "Warning"
        static let noCamera = "You don't have camera"
        static let noPermissionPhotoLibrary = "No permission to open photo library"
        static let ok = "OK"
    }
    
    struct TextAlert {
        static let error = "Error"
        static let success = "Success"
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
    
    struct UserPizzaCell {
        static let cellIdentifier = "ReusableUserPizzaCell"
        static let cellNibName = "UserPizzaCell"
    }
    
    struct UserSettingsCell {
        static let cellIdentifier = "ReusableUserSettingsCell"
        static let cellNibName = "UserSettingsCell"
    }
    
    struct PersonalDetailsCell {
        static let cellIdentifier = "ReusablePersonalDetailsCell"
        static let cellNibName = "PersonalDetailsCell"
    }
    
    struct postfixes {
        static let gram = "g"
        static let hour = "h"
        static let percent = "%"
        static let blank = ""
    }
}
