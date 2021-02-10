//
//  DoughEquations.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 09/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import Foundation

struct DoughEquations {
    
    func getIngredients(doughProperties: DoughProperties) -> [Int:Int] {
        
        let yeast = 1
        
        let totalWeight = doughProperties.ballWeight! * doughProperties.ballsAmount!
        print(totalWeight)
        let estimatedFlour = totalWeight * doughProperties.hydration!/100
        print("estimatedFlour= \(estimatedFlour)")
        
        let estimatedWater = estimatedFlour * doughProperties.hydration!/100
        print("estimatedWater = \(estimatedWater)")
        
        let salt = round(Double(doughProperties.salt!) * Double(estimatedWater) / 1000)
        let fat = round(Double(doughProperties.fat!) * Double(estimatedWater) / 1000)
        
        let waterAndFlour = totalWeight - Int(salt) - Int(fat)
        print("waterAndFlour = \(waterAndFlour)")
        
        let flour = round(Double((waterAndFlour)) / (1 + Double(doughProperties.hydration!) / 100))
        print("flour = \(flour)")
        
        let water = round(flour * Double(doughProperties.hydration!) / 100)
        print("water = \(water)")
        
        let array = [1:Int(flour),
                      2:Int(water),
                      3:Int(yeast),
                      4:Int(salt),
                      5:Int(fat)
        ]
        return array
    }
}
