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
        let dictionary = [K.DoughEquations.flour:Int(flour),
                     K.DoughEquations.water:Int(water),
                     K.DoughEquations.yeast:yeast,
                     K.DoughEquations.salt:Int(salt),
                     K.DoughEquations.fat:Int(fat),
                     K.DoughEquations.ballWeight:doughProperties.ballWeight!,
                     K.DoughEquations.portions:doughProperties.ballsAmount!,
                     K.DoughEquations.hydration:doughProperties.hydration!,
                     K.DoughEquations.roomTime:doughProperties.totalTime! - doughProperties.fridgeTime!,
                     K.DoughEquations.fridgeTime:doughProperties.fridgeTime!
        ] as [String : Any]
        return dictionary
    }
}
