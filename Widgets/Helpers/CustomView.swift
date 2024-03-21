//
//  CustomView.swift
//  Widgets
//
//  Created by Apple on 20/10/20.
//

import UIKit

class BottomRoundView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = Colors.DarkColor
        roundCorners(corners: [.bottomLeft, .bottomRight], radius: 40.0)
    }
    
//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
}
