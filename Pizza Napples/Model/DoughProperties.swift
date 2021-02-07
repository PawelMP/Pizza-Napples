//
//  DoughProperties.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 07/02/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

public struct DoughProperties: Codable {
    
    let ballsAmount: Int?
    let ballWeight: Int?
    let hydration: Int?
    let salt: Int?
    let fat: Int?
    
    let totalTime: Int?
    let fridgeTime: Int?
    let temperature: Int?

    enum CodingKeys: String, CodingKey {
        case ballsAmount
        case ballWeight
        case hydration
        case salt
        case fat
        
        case totalTime
        case fridgeTime
        case temperature
    }
    
    var dictionary: [String: Any] {
            let data = (try? JSONEncoder().encode(self)) ?? Data()
            return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        }
    
}
