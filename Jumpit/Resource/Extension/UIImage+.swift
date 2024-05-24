//
//  UIImage+.swift
//  Jumpit
//
//  Created by YOUJIM on 5/24/24.
//

import UIKit


extension UIImage {
    func resize(targetSize: CGSize) -> UIImage? {
            let newRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height).integral
            UIGraphicsBeginImageContextWithOptions(newRect.size, true, 0)
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            context.interpolationQuality = .high
            draw(in: newRect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
}
