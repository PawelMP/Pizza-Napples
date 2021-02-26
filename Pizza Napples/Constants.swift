//
//  Constants.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 20/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestoreSwift

struct K {

    static let pizzaNapplesName = "🍕 Pizza Napples 🍕"
    static let modifyProportionsButtonName = " Modify proportions "
    static let usersPizzas = "Users pizzas"
    static let pleaseWriteDescription = "Please write a description"
    static let pickerControllerEditedImage = "UIImagePickerControllerEditedImage"
    static let author = "Author: "
    static let pleaseTypeEmail = "Please type in your e-mail"
    static let pleaseTypeUsername = "Please type in your username"
    
    struct Design {
        
        struct Color {
            static let Beige = UIColor(red: 0.97, green: 0.96, blue: 0.92, alpha: 1.00)
            static let DarkGrey = UIColor(red: 0.25, green: 0.27, blue: 0.29, alpha: 1.00)
            static let Red = UIColor.red
        }
        
        struct Image {
            static let LockFill = UIImage(systemName: "lock.fill")
            static let PersonSquare = UIImage(systemName: "person.crop.square.fill.and.at.rectangle")
            static let PersonCircle = UIImage(systemName: "person.circle")
            static let LogoutSymbol = UIImage(systemName: "arrow.left.square")
        }
        
        struct Font {
            static let futura = "Futura"
            static let MarkerFeltThin = UIFont(name: "Marker Felt Thin", size: 25)
        }
    }
    
    struct Content {
        
        static let Email = "E-mail"
        static let Username = "Username"
        static let UsernameLowercase = "username"
        static let Error = "Error"
        static let Success = "Success"
        static let OK = "OK"
        static let NoData = "No data"
        static let Date = "date"
        static let Images = "images"
        static let Slash = "/"
        static let Dot = "."
        static let Png = "png"
        static let Gram = "g"
        static let Hour = "h"
        static let Percent = "%"
        static let Blank = ""
        static let Cancel = "Cancel"
        static let Warning = "Warning"
        
        static let PasswordResetSent = "Password reset sent to e-mail"
        static let FillMissingField = "Please fill missing fields"
        static let PasswordsDoNotMatch = "Passwords do not match"
        static let ProfileUpdateSuccess = "Succesfully updated profile"
        
        static let DisplayName = "Display name: "

        struct CalculatorBrain {
            static let BallsNumberDescription = "Number of total dough balls"
            static let BallsNumberPlaceholder = "How many dough balls?"
            static let ValueGreaterThan0Error = "Value must be greater than 0"
            static let BallWeightDescription = "Single ball weight [g]"
            static let BallWeightPlaceholder = "Enter ball weight"
            static let HydrationDescription = "Hydration [%]"
            static let HydrationPlaceholder = "Enter hydration"
            static let HydrationError = "Value must be between 45% and 120%"
            static let SaltDescription = "Salt per litre of water [g]"
            static let SaltPlaceholder = "Enter amount of salt"
            static let FatDescription = "Liquid fat per litre of water [g]"
            static let FatPlaceholder = "Enter amount of fat"
            
            static let GrowthTimeDescription = "Total growth time [h]"
            static let GrowthTimePlaceholder = "Total growth time"
            static let GrowthTimeError = "Value must be between 1 and 168 hours"
            static let FridgeTimeDescription = "Growth time in fridge [h]"
            static let FridgeTimePlaceholder = "Fridge growth time"
            static let FridgeTimeError = "Fridge growth time must be less than total growth time"
            static let TemperatureDescription = "Ambient temperature [°C]"
            static let TemperaturePlaceholder = "Room temperature"
            static let TemperatureError = "Value must be between 15 C° and 35 C°"
            
            static let DoughProportions = "Dough proportions"
            static let GrowthTime = "Growth time"
            static let SpaceSign = " "
            static let Empty = ""
            static let TotalGrowthTime = "Total growth time [h]"
        }
        
        struct UserSettings {
            static let Welcome = "Welcome "
            static let PersonalDetails = "My personal details"
            static let ChangePassword = "Change password"
            static let Logout = "Logout"
        }
        
        struct DoughEquations {
            static let Flour = "flour"
            static let Water = "water"
            static let Yeast = "yeast"
            static let Salt = "salt"
            static let Fat = "fat"
            static let BallWeight = "ball weight"
            static let Portions = "portions"
            static let Hydration = "hydration"
            static let RoomTime = "room"
            static let FridgeTime = "fridge"
        }
        
        struct PhotosManager {
            static let ChooseImage = "Choose Image"
            static let Camera = "Camera"
            static let Gallery = "Gallery"
            static let NoCamera = "You don't have camera"
            static let NoPermissionPhotoLibrary = "No permission to open photo library"
        }
        
    }
    
    struct API {
        static let AUTH_REF = Auth.auth()
        static let DB_REF = Firestore.firestore()
        static let USER_DOUGH_REF = "users dough"
        static let USERS_DOUGH_DB_REF = DB_REF.collection(USER_DOUGH_REF)
        static let USERS_PIZZA_REF = "users pizza"
        static let USERS_PIZZA_DB_REF = DB_REF.collection(USERS_PIZZA_REF)
        static let STORAGE = Storage.storage()
        static let STORAGE_REF = STORAGE.reference()
    }
    
    struct Segues {
        static let RegisterToApp = "registerToApp"
        static let LoginToApp = "loginToApp"
        static let UsersPizzasToAddNewPhoto = "usersPizzasToAddNewPhoto"
        static let ToPizzaDetails = "toPizzaDetails"
        static let UserLoggedToApp = "userLoggedToApp"
        static let ToCreateUsername = "toCreateUsername"
        static let ToUserSettings = "toUserSettings"
        static let ToReauthenticate = "toReauthenticate"
        static let ToPasswordChange = "toPasswordChange"
        static let ToPersonalDetails = "toPersonalDetails"
    }
    
    struct Screen {
        static let Height = UIScreen.main.bounds.size.height
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
    
}
