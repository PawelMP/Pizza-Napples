//
//  UIResponder.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 27/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

import UIKit

extension UIResponder {
    func findParentTableViewCell () -> UITableViewCell? {
        var parent: UIResponder = self
        while let next = parent.next {
            if let tableViewCell = parent as? UITableViewCell {
                return tableViewCell
            }
            parent = next
        }
        return nil
    }
}
