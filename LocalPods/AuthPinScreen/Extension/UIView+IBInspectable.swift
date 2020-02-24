//
//  UIView+IBInspectable.swift
//  AuthPinScreen
//
//  Created by Maria on 24.02.2020.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius  }
        set { layer.cornerRadius = newValue }
    }
    
}
