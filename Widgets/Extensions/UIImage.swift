//
//  UIImage.swift
//  Template_Onboarding
//
//  Created by Pedro Muñoz Cabrera on 08/03/2021.
//

import UIKit



extension UIImage {
    
    public func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

