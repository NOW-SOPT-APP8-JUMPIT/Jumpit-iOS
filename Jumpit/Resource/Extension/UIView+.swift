//
//  UIView+.swift
//  Jumpit
//
//  Created by YOUJIM on 5/24/24.
//


import UIKit


extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}
