//
//  UIButton+Extension.swift
//  Widgets
//
//  Created by Apple on 17/10/20.
//

import Foundation
import UIKit

class FilledButton: UIButton {
    private var shadowLayer: CAShapeLayer!
    var fillColor: UIColor =  UIColor.systemOrange//Colors.LightColor // the color applied to the shadowLayer, rather than the view's backgroundColor
     
    @IBInspectable open var radius: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        setTitleColor(UIColor.white, for: .normal)
        //roundCorner()
        titleLabel?.font = Fonts.SemiBoldFont
        
        
        if shadowLayer != nil {
            shadowLayer.removeFromSuperlayer()
            shadowLayer = nil
        }

        shadowLayer = CAShapeLayer()
          
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        shadowLayer.fillColor = fillColor.cgColor

        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 5
            
        layer.insertSublayer(shadowLayer, at: 0)
    }

}

class TextOnlyButton: UIButton {
    override func awakeFromNib() {
        setTitleColor(Colors.DarkColor, for: .normal)
        titleLabel?.font = Fonts.BoldFont
    }
}
