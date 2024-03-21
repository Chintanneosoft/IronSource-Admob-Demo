//
//  UIFont+Extensions.swift
//  Template_Onboarding
//
//  Created by Pedro Muñoz Cabrera on 08/03/2021.
//

import UIKit


public extension UIFont {
    @available(iOS 13.0, *)
    static func font(ofSize size: CGFloat, weight: UIFont.Weight, design: UIFontDescriptor.SystemDesign = .default) -> UIFont {
            if let descriptor = UIFont.systemFont(ofSize: size, weight: weight).fontDescriptor.withDesign(design) {
                return UIFont(descriptor: descriptor, size: size)
            } else {
                return UIFont.systemFont(ofSize: size, weight: weight)
            }
    }
}

