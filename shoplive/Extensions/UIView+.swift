//
//  UIView+.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import UIKit

extension UIView {
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    func borderWidth(_ width: CGFloat) -> Self {
        layer.borderWidth = width
        return self
    }
    
    @discardableResult
    func borderColor(_ borderColor: UIColor) -> Self {
        layer.borderColor = borderColor.cgColor
        return self
    }
    
}
