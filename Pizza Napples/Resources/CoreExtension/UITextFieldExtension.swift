//
//  UITextFieldExtension.swift
//  Pizza Napples
//
//  Created by Paweł Pietrzyk on 20/01/2021.
//  Copyright © 2021 Paweł Pietrzyk. All rights reserved.
//

//
//  UITextFieldExtension.swift
//  Steaker
//
//  Created by Paweł Pietrzyk on 15/10/2020.
//  Copyright © 2020 Paweł Pietrzyk. All rights reserved.
//

import UIKit

extension UITextField{
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
        }
    }
}
