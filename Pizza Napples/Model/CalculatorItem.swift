//
//  CalculatorItem.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 19/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import Foundation

struct CalculatorItem {
    let description: String
    let placeholder: String
    
    let error: String
    
    var amount: Int?
    
    let minValue: Int?
    var maxValue: Int?
    
    var isValueCorrect: Bool
}
