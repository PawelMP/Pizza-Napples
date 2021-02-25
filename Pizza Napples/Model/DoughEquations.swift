//
//  DoughEquations.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 09/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import Foundation

struct DoughEquations {
    
    //Calculate ingredients based on the given properties
    func getIngredients(doughProperties: DoughProperties) -> [String:Any] {
        
        let hydration = Double(doughProperties.hydration!)
        
        let totalWeight = Double(doughProperties.ballWeight!) * Double(doughProperties.ballsAmount!)

        let estimatedFlour = totalWeight * hydration / 100
        
        let estimatedWater = estimatedFlour * hydration / 100
        
        let salt = round(Double(doughProperties.salt!) * estimatedWater / 1000)
        let fat = round(Double(doughProperties.fat!) * estimatedWater / 1000)
        
        let waterAndFlour = totalWeight - salt - fat
        
        let flour = round(waterAndFlour / (hydration / 100 + 1))
        
        let water = round(flour * hydration / 100)
        
        let yeast = flour / 1000
        
        //assign results to dictionary
        let dictionary = [K.Content.DoughEquations.Flour:Int(flour),
                          K.Content.DoughEquations.Water:Int(water),
                          K.Content.DoughEquations.Yeast:yeast,
                          K.Content.DoughEquations.Salt:Int(salt),
                          K.Content.DoughEquations.Fat:Int(fat),
                          K.Content.DoughEquations.BallWeight:doughProperties.ballWeight!,
                          K.Content.DoughEquations.Portions:doughProperties.ballsAmount!,
                          K.Content.DoughEquations.Hydration:doughProperties.hydration!,
                          K.Content.DoughEquations.RoomTime:doughProperties.totalTime! - doughProperties.fridgeTime!,
                          K.Content.DoughEquations.FridgeTime:doughProperties.fridgeTime!
        ] as [String : Any]
        return dictionary
    }
}
