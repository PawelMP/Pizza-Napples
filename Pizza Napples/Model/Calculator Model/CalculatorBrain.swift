//
//  CalculatorBrain.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 16/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var doughProportions = [
        CalculatorItem(description: K.Content.CalculatorBrain.BallsNumberDescription, placeholder: K.Content.CalculatorBrain.BallsNumberPlaceholder, error: K.Content.CalculatorBrain.ValueGreaterThan0Error, amount: nil, minValue: 1, maxValue: nil, isValueCorrect: false),
        CalculatorItem(description: K.Content.CalculatorBrain.BallWeightDescription, placeholder: K.Content.CalculatorBrain.BallWeightPlaceholder, error: K.Content.CalculatorBrain.ValueGreaterThan0Error, amount: nil, minValue: 1, maxValue: nil, isValueCorrect: false),
        CalculatorItem(description: K.Content.CalculatorBrain.HydrationDescription, placeholder: K.Content.CalculatorBrain.HydrationPlaceholder, error: K.Content.CalculatorBrain.HydrationError, amount: nil, minValue: 45, maxValue: 120, isValueCorrect: false),
        CalculatorItem(description: K.Content.CalculatorBrain.SaltDescription, placeholder: K.Content.CalculatorBrain.SaltPlaceholder, error: K.Content.CalculatorBrain.SpaceSign, amount: nil, minValue: nil, maxValue: nil, isValueCorrect: true),
        CalculatorItem(description: K.Content.CalculatorBrain.FatDescription, placeholder: K.Content.CalculatorBrain.FatPlaceholder, error: K.Content.CalculatorBrain.SpaceSign, amount: nil, minValue: nil, maxValue: nil, isValueCorrect: true)
    ]
    
    var doughGrowth = [
        CalculatorItem(description: K.Content.CalculatorBrain.GrowthTimeDescription, placeholder: K.Content.CalculatorBrain.GrowthTimePlaceholder, error: K.Content.CalculatorBrain.GrowthTimeError, amount: nil, minValue: 1, maxValue: 168, isValueCorrect: false),
        CalculatorItem(description: K.Content.CalculatorBrain.FridgeTimeDescription, placeholder: K.Content.CalculatorBrain.FridgeTimePlaceholder, error: K.Content.CalculatorBrain.FridgeTimeError, amount: nil, minValue: nil, maxValue: nil, isValueCorrect: false),
        CalculatorItem(description: K.Content.CalculatorBrain.TemperatureDescription, placeholder: K.Content.CalculatorBrain.TemperaturePlaceholder, error: K.Content.CalculatorBrain.TemperatureError, amount: nil, minValue: 15, maxValue: 35, isValueCorrect: false)
    ]
    
    //Get number of sections in tableView
    func getSections () -> Int {
        return 2
    }
    
    //Get name for each section
    func getName (for section: Int) -> String {
        if(section == 0) {
            return K.Content.CalculatorBrain.DoughProportions
        }
        else if (section == 1) {
            return K.Content.CalculatorBrain.GrowthTime
        }
        else {
            return K.Content.CalculatorBrain.Empty
        }
    }
    
    //Get number of rows for each section
    func getRowsForSections (for section: Int) -> Int {
        if(section == 0) {
            return doughProportions.count
        }
        else if(section == 1) {
            return doughGrowth.count
        }
        else {
            return 0
        }
    }
    
    //Save given value
    mutating func saveAmount (with value: Int?, indexPath: IndexPath) {
        if indexPath.section == 0 {
            doughProportions[indexPath.row].amount = value
            if doughProportions[indexPath.row].minValue != nil || doughProportions[indexPath.row].maxValue != nil {
                doughProportions[indexPath.row].isValueCorrect = false
            }
        }
        else if indexPath.section == 1 {
            doughGrowth[indexPath.row].amount = value
            doughGrowth[indexPath.row].isValueCorrect = false
        }
    }
    
    //Check if given value is correct
    mutating func checkAmount (with value: Int?, for indexPath: IndexPath, cell: DoughCell) {
        
        guard let value = value else {
            return
        }
        
        //Check if value is higher/lower than minimum
        func checkMin (with value: Int, comparing min: Int) -> Bool {
            if min > value {
                return false
            }
            else {
                return true
            }
        }
        //Check if value is higher/lower than maximum
        func checkMax (with value: Int, comparing max: Int) -> Bool {
            if max < value {
                return false
            }
            else {
                return true
            }
        }
        
        saveAmount(with: value, indexPath: indexPath)
        
        //For section 0 = Dough Proportions
        if indexPath.section == 0 {
            if let max = doughProportions[indexPath.row].maxValue {
                if checkMax(with: value, comparing: max) {
                    doughProportions[indexPath.row].isValueCorrect = true
                }
                else {
                    doughProportions[indexPath.row].isValueCorrect = false
                    return
                }
            }
            
            if let min = doughProportions[indexPath.row].minValue {
                if checkMin(with: value, comparing: min) {
                    doughProportions[indexPath.row].isValueCorrect = true
                }
                else {
                    doughProportions[indexPath.row].isValueCorrect = false
                    return
                }
            }
        }
        
        //For section 1 = Dough Growth
        else if indexPath.section == 1 {
            
            if let max = doughGrowth[indexPath.row].maxValue {
                if checkMax(with: value, comparing: max) {
                    doughGrowth[indexPath.row].isValueCorrect = true
                }
                else {
                    doughGrowth[indexPath.row].isValueCorrect = false
                    return
                }
            }
            
            if let min = doughGrowth[indexPath.row].minValue {
                if checkMin(with: value, comparing: min) {
                    doughGrowth[indexPath.row].isValueCorrect = true
                }
                else {
                    doughGrowth[indexPath.row].isValueCorrect = false
                    return
                }
            }
            
            //Additional condition for total time and fridge time
            if doughGrowth[indexPath.row].description == K.Content.CalculatorBrain.GrowthTimeDescription {
                doughGrowth[indexPath.row + 1].maxValue = doughGrowth[indexPath.row].amount
                if let maxValue = doughGrowth[indexPath.row + 1].maxValue, let amount = doughGrowth[indexPath.row + 1].amount  {
                    if maxValue <= amount {
                        doughGrowth[indexPath.row + 1].isValueCorrect = false
                        return
                    }
                    else {
                        doughGrowth[indexPath.row + 1].isValueCorrect = true
                    }
                }
            }
            
        }
    }
    
    //Check is all values are correct - to enable/disable button
    func checkAllElements() -> Bool {
        for item in doughProportions {
            if !item.isValueCorrect || item.amount == nil {
                return false
            }
        }
        
        for item in doughGrowth {
            if !item.isValueCorrect || item.amount == nil {
                return false
            }
        }
        return true
    }
    
}
