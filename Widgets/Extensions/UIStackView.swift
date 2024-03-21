//
//  UIStackView.swift
//  Template_Onboarding
//
//  Created by Pedro Muñoz Cabrera on 08/03/2021.
//

import UIKit

public extension UIStackView {
    convenience init(arrangedSubviews: [UIView] = [],
                     axis: NSLayoutConstraint.Axis = .horizontal,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill,
                     spacing: CGFloat = UIStackView.spacingUseDefault) {
        self.init()
        addArrangedSubviews(arrangedSubviews)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        self.distribution = distribution
    }

    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }

    func removeAllArrangedSubviews() {
        for subview in arrangedSubviews {
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}

