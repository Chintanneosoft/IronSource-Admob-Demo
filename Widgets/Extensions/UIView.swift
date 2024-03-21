//
//  UIView.swift
//  Template_Onboarding
//
//  Created by Pedro Muñoz Cabrera on 08/03/2021.
//

import UIKit

// MARK: UIView+LoadFromNib


public extension UIView {
    class func loadFromNib() -> Self? {
        return loadFromNib(nibNamed: nil, nil)
    }

    /// Use this method init view from nib.
    class func loadFromNib<T: UIView>(nibNamed: String?, _ bundle: Bundle?) -> T? {
        let name = nibNamed ?? String(describing: T.self)
        let nib =  UINib(nibName: name, bundle: bundle)
        return nib.instantiate(withOwner: T.self, options: nil)[0] as? T
    }

    /// Use this method for setup with fileOwner.
    func setupXib<T: UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self))
            .loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {
                return nil
        }
        contentView.frame = bounds
        backgroundColor = contentView.backgroundColor
        contentView.backgroundColor = .clear
        contentView.addToView(self)
        return contentView
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat, rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

// MARK: UIView+NSLayoutConstraint
public extension UIView {
    func addToView(_ containerView: UIView, top: CGFloat? = 0, bottom: CGFloat? = 0, left: CGFloat? = 0, right: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(self)

        if let top = top {
            topAnchor.constraint(equalTo: containerView.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: bottom).isActive = true
        }
        if let leading = left {
            leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = right {
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: trailing).isActive = true
        }
    }

    func constraint(height: CGFloat? = nil, width: CGFloat? = nil) {
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }

    func constraintToSuperview(centerX: CGFloat? = nil, centerY: CGFloat? = nil) {
        guard let superview = superview else {
            assertionFailure("View did'h have superview for X and Y axis constraint")
            return
        }

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: centerX).isActive = true
        }
        if let centerY = centerY {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: centerY).isActive = true
        }
    }

    func constraintToView(_ view: UIView, equalWidth: Bool, equalHeight: Bool) {
        if equalWidth {
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        }
        if equalHeight {
            heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        }
    }
    
    func alignConstraintsToView(_ view: UIView, top: CGFloat? = 0, bottom: CGFloat? = 0, left: CGFloat? = 0, right: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        let margin = view.safeAreaLayoutGuide
        if let top = top {
            topAnchor.constraint(equalTo: margin.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: bottom).isActive = true
        }
        if let leading = left {
            leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = right {
            trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: trailing).isActive = true
        }
    }
    
    func aspectView(height: CGFloat, width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .width,
                                              multiplier: height / width,
                                              constant: 0))
    }
}

// MARK: UIView+Shadows
public extension UIView {
    private enum Constants {
        static let shadowTag: Int = 999
    }

    struct ShadowParameters {
        var color: UIColor
        var opacity: Float
        var offset: CGSize
        var radius: CGFloat

        public init(color: UIColor = .clear, opacity: Float = 1, offset: CGSize = .zero, radius: CGFloat =  0) {
            self.color = color
            self.opacity = opacity
            self.offset = offset
            self.radius = radius
        }
    }
    
    func setShadow(with parameters: ShadowParameters) {
        func addShadowView(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
            var shadowView = superview?.subviews.first(where: { $0.tag == Constants.shadowTag })

            if shadowView == nil {
                let shadow = UIView()
                shadow.tag = Constants.shadowTag
                superview?.insertSubview(shadow, belowSubview: self)
                shadow.alignConstraintsToView(self)
                shadowView = shadow
            }

            shadowView?.layer.shadowColor = color.cgColor
            shadowView?.layer.shadowOffset = offset
            shadowView?.layer.masksToBounds = false

            shadowView?.layer.shadowOpacity = opacity
            shadowView?.layer.shadowRadius = radius
            shadowView?.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            shadowView?.layer.rasterizationScale = UIScreen.main.scale
            shadowView?.layer.shouldRasterize = true
        }

        func addShadowToLayer(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
            layer.shadowColor = color.cgColor
            layer.shadowOffset = offset
            layer.shadowOpacity = opacity
            layer.shadowRadius = radius
        }

        clipsToBounds ? addShadowView(color: parameters.color, opacity: parameters.opacity, offset: parameters.offset, radius: parameters.radius) :
            addShadowToLayer(color: parameters.color, opacity: parameters.opacity, offset: parameters.offset, radius: parameters.radius)
    }

    func removeShadow() {
        superview?.subviews.first(where: { $0.tag == Constants.shadowTag })?.removeFromSuperview()
        layer.shadowColor = nil
        layer.shadowOpacity = 0
    }
}

// MARK: UIView+Size
public extension UIView {
    static var visiblePixelSize: CGFloat {
        let scale = UIScreen.main.scale
        if scale > 1 {
            // Keep this value also for devices with x3 screen resolutions because this devices used downsampling of rendered screen
            return 0.5
        } else {
            return 1.0
        }
    }
}

// MARK: UIView+Animation
public extension UIView {
    func updateLayout(animated: Bool = true) {
        setNeedsUpdateConstraints()
        setNeedsLayout()

        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.layoutIfNeeded()
        }
    }

    func alpha(_ alpha: CGFloat, animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.alpha = alpha
        }
    }
    
    static func perform(animated: Bool, animations: @escaping VoidClosure) {
        perform(animated: animated, animations: animations, completion: { _ in })
    }
    
    static func perform(animated: Bool, animations: @escaping VoidClosure, completion: @escaping BoolClosure) {
        if animated {
            UIView.animate(withDuration: 0.25, animations: animations, completion: completion)
        } else {
            animations()
            completion(true)
        }
    }
}

// MARK: UIView+Image
public extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

// MARK: UIView+Style
public extension UIView {
    func roundAllCornersWithMaximumRadius() {
        cornerRadius = min(frame.width, frame.height) / 2.0
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
}



public extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func rounded(radius: CGFloat? = nil, _ corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
        let radius = radius ?? min(bounds.height, bounds.width) / 2
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        layer.masksToBounds = true
    }

}

extension UIView {
    
    var frameWithoutTransform: CGRect {
        let center = self.center
        let size   = self.bounds.size
        
        return CGRect(x: center.x - size.width  / 2,
                      y: center.y - size.height / 2,
                      width: size.width,
                      height: size.height)
    }

}


extension UIView {

    func canBeHugging(_ canHugge: Bool) -> Self {
        let huggingPriority: UILayoutPriority = canHugge ? .defaultLow : .required
        setContentHuggingPriority(huggingPriority, for: .vertical)
        setContentHuggingPriority(huggingPriority, for: .horizontal)
        return self
    }

    func canBeCompressed(_ canCompresse: Bool) -> Self {
        let compressionPriority: UILayoutPriority = canCompresse ? .defaultLow : .required
        setContentCompressionResistancePriority(compressionPriority, for: .vertical)
        setContentCompressionResistancePriority(compressionPriority, for: .horizontal)
        return self
    }

    func canBeResized(_ canResize: Bool) -> Self {
        canBeHugging(canResize).canBeCompressed(canResize)
    }

}


