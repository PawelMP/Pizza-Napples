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
        CalculatorItem(description: "Number of total dough balls", placeholder: "How many dough balls?", error: "Value must be higher than 0", amount: nil, minValue: 1, maxValue: nil, isValueCorrect: false),
        CalculatorItem(description: "Single ball weight [g]", placeholder: "Enter ball weight", error: "Value must be higher than 0", amount: nil, minValue: 1, maxValue: nil, isValueCorrect: false),
        CalculatorItem(description: "Hydration [%]", placeholder: "Enter hydration", error: "Value must be between 45% and 120%", amount: nil, minValue: 45, maxValue: 120, isValueCorrect: false),
        CalculatorItem(description: "Salt per litre of water [g]", placeholder: "Enter amount of salt", error: " ", amount: nil, minValue: nil, maxValue: nil, isValueCorrect: true),
        CalculatorItem(description: "Liquid fat per litre of water [g]", placeholder: "Enter amount of fat", error: " ", amount: nil, minValue: nil, maxValue: nil, isValueCorrect: true)
    ]
    
    var doughGrowth = [
        CalculatorItem(description: "Total growth time [h]", placeholder: "Total growth time", error: "Value must be between 1 and 168 hours", amount: nil, minValue: 1, maxValue: 168, isValueCorrect: false),
        CalculatorItem(description: "Growth time in fridge [h]", placeholder: "Fridge growth time", error: "Fridge growth time must be less than total growth time", amount: nil, minValue: nil, maxValue: nil, isValueCorrect: false),
        CalculatorItem(description: "Ambient temperature [°C]", placeholder: "Room temperature", error: "Value must be between 15 C° and 35 C°", amount: nil, minValue: 15, maxValue: 35, isValueCorrect: false)
    ]
    
    //Setup tableview
    func setupTableView(tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.90, alpha: 1.00)
        
        
        //Stop the table view headers from floating
        let dummyViewHeight = CGFloat(40)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: dummyViewHeight))
        tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        
        //Make next/previous button on toolbar scroll to row
        tableView.estimatedRowHeight = 1
        
        //Register custom cell
        tableView.register(UINib(nibName: DoughCell.cellNibName, bundle: nil), forCellReuseIdentifier: DoughCell.cellIdentifier)
    }
    
    //Get number of sections in tableView
    func getSections () -> Int {
        return 2
    }
    
    //Get name for each section
    func getName (for section: Int) -> String {
        if(section == 0) {
            return K.CalculatorBrain.doughProportions
        }
        else if (section == 1) {
            return K.CalculatorBrain.growthTime
        }
        else {
            return K.CalculatorBrain.empty
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
    
    //Configre the header view
    func configureHeaderView (for header: UITableViewHeaderFooterView) {
        header.textLabel?.font = UIFont(name: K.futura, size: 20)!
        header.contentView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.90, alpha: 1.00)
    }
    
    //Configure header height
    func configureHeaderHeight () -> CGFloat {
        return 50
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
    
    //Check if value is higher/lower than minimum
    func checkMin (with value: Int, comparing min: Int, for indexPath: IndexPath) -> Bool {
        if min > value {
            return false
        }
        else {
            return true
        }
    }
    //Check if value is higher/lower than maximum
    func checkMax (with value: Int, comparing max: Int, for indexPath: IndexPath) -> Bool {
        if max < value {
            return false
        }
        else {
            return true
        }
    }
    
    //Check if given value is correct
    mutating func checkAmount (with value: Int?, for indexPath: IndexPath, cell: DoughCell) {
        
        guard let value = value else {
            return
        }
        
        saveAmount(with: value, indexPath: indexPath)
        
        //For section 1 = Dough Proportions
        if indexPath.section == 0 {
            if let max = doughProportions[indexPath.row].maxValue {
                if checkMax(with: value, comparing: max, for: indexPath) {
                    doughProportions[indexPath.row].isValueCorrect = true
                }
                else {
                    doughProportions[indexPath.row].isValueCorrect = false
                    return
                }
            }
            
            if let min = doughProportions[indexPath.row].minValue {
                if checkMin(with: value, comparing: min, for: indexPath) {
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
                if checkMax(with: value, comparing: max, for: indexPath) {
                    doughGrowth[indexPath.row].isValueCorrect = true
                }
                else {
                    doughGrowth[indexPath.row].isValueCorrect = false
                    return
                }
            }
            
            if let min = doughGrowth[indexPath.row].minValue {
                if checkMin(with: value, comparing: min, for: indexPath) {
                    doughGrowth[indexPath.row].isValueCorrect = true
                }
                else {
                    doughGrowth[indexPath.row].isValueCorrect = false
                    return
                }
            }
            
            //Additional condition for total time and fridge time
            if doughGrowth[indexPath.row].description == K.CalculatorBrain.totalGrowthTime {
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
