//
//  UIView+Extension.swift
//  SeeSaw
//
//  Created by apple on 01/01/20.
//  Copyright © 2020 Sherry. All rights reserved.
//

import UIKit

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

extension UIView {
    func circle() {
        layer.cornerRadius = bounds.size.width/2
        layer.masksToBounds = true
    }
    
    func roundAndBorder() {
        layer.cornerRadius = bounds.size.width/2
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = Colors.DarkColor.cgColor
    }
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func dropShadowBlack() {
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 6, height: 7)
        layer.masksToBounds = false

        layer.shadowOpacity = 1.0
        layer.shadowRadius = 30
        
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    
    func dropShadowLow() {
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.masksToBounds = false

        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4
        
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    
    
    func dropShadow() {
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 6, height: 7)
        layer.masksToBounds = false

        layer.shadowOpacity = 1.0
        layer.shadowRadius = 30
        
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    
    func dropRoundShadow( with radius: CGFloat) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.masksToBounds = false

        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
        layer.cornerRadius = radius
        
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }

    
    func roundCorner(){
        layer.cornerRadius = min(self.bounds.size.width/2, self.bounds.size.height/2)
        layer.masksToBounds = true
    }

    func roundCorner(_ radius: Int){
        layer.cornerRadius = CGFloat(radius)
        layer.masksToBounds = true
    }
}

class CircleShadowView: UIView {
    private var shadowLayer: CAShapeLayer!
    var fillColor: UIColor =  .white // the color applied to the shadowLayer, rather than the view's backgroundColor
     
    @IBInspectable open var radius: CGFloat = 20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        
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
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
            
        layer.insertSublayer(shadowLayer, at: 0)
    }
}

class TopCornerCircleShadowView: UIView {
    private var shadowLayer: CAShapeLayer!
    var fillColor: UIColor =  .white // the color applied to the shadowLayer, rather than the view's backgroundColor
     
    @IBInspectable open var radius: CGFloat = 20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        
        if shadowLayer != nil {
            shadowLayer.removeFromSuperlayer()
            shadowLayer = nil
        }

        shadowLayer = CAShapeLayer()
          
        shadowLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: cornerRadius)).cgPath
        shadowLayer.fillColor = fillColor.cgColor

        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
            
        layer.insertSublayer(shadowLayer, at: 0)
    }
}


class BottomCornerCircleShadowView: UIView {
    private var shadowLayer: CAShapeLayer!
    @IBInspectable open var fillColor: UIColor =  .white // the color applied to the shadowLayer, rather than the view's backgroundColor
     
    @IBInspectable open var radius: CGFloat = 20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        
        if shadowLayer != nil {
            shadowLayer.removeFromSuperlayer()
            shadowLayer = nil
        }

        shadowLayer = CAShapeLayer()
          
        shadowLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: cornerRadius)).cgPath
        shadowLayer.fillColor = fillColor.cgColor

        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        shadowLayer.shadowOpacity = 1.2
        shadowLayer.shadowRadius = 10
            
        layer.insertSublayer(shadowLayer, at: 0)
    }
}

class RoundedView: UIView {
    @IBInspectable open var radius: CGFloat = 20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

class RoundedImageView: UIImageView {
    @IBInspectable open var radius: CGFloat = 20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

class CircleImageView: UIImageView {
    override func awakeFromNib() {
        image = UIImage(named: "placeholderImage")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = max(self.bounds.size.width,self.bounds.size.height)/2
        self.layer.masksToBounds = true
    }
}


extension UIButton {
     @objc func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }
}

extension UIView {
    func applyGradientView(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
       
    }
}


extension UILabel {

    func applyGradientWith(startColor: UIColor, endColor: UIColor) -> Bool {

        var startColorRed:CGFloat = 0
        var startColorGreen:CGFloat = 0
        var startColorBlue:CGFloat = 0
        var startAlpha:CGFloat = 0

        if !startColor.getRed(&startColorRed, green: &startColorGreen, blue: &startColorBlue, alpha: &startAlpha) {
            return false
        }

        var endColorRed:CGFloat = 0
        var endColorGreen:CGFloat = 0
        var endColorBlue:CGFloat = 0
        var endAlpha:CGFloat = 0

        if !endColor.getRed(&endColorRed, green: &endColorGreen, blue: &endColorBlue, alpha: &endAlpha) {
            return false
        }

        let gradientText = self.text ?? ""

        let name:NSAttributedString.Key = NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue)
        let textSize: CGSize = gradientText.size(withAttributes: [name:self.font!])
        let width:CGFloat = textSize.width
        let height:CGFloat = textSize.height

        UIGraphicsBeginImageContext(CGSize(width: width, height: height))

        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return false
        }

        UIGraphicsPushContext(context)

        let glossGradient:CGGradient?
        let rgbColorspace:CGColorSpace?
        let num_locations:size_t = 2
        let locations:[CGFloat] = [ 0.25, 1.0 ]
        let components:[CGFloat] = [startColorRed, startColorGreen, startColorBlue, startAlpha, endColorRed, endColorGreen, endColorBlue, endAlpha]
        rgbColorspace = CGColorSpaceCreateDeviceRGB()
        glossGradient = CGGradient(colorSpace: rgbColorspace!, colorComponents: components, locations: locations, count: num_locations)
        let topCenter = CGPoint.zero
        let bottomCenter = CGPoint(x: 0, y: textSize.height)
        context.drawLinearGradient(glossGradient!, start: topCenter, end: bottomCenter, options: CGGradientDrawingOptions.drawsBeforeStartLocation)

        UIGraphicsPopContext()

        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return false
        }

        UIGraphicsEndImageContext()

        self.textColor = UIColor(patternImage: gradientImage)

        return true
    }

}
