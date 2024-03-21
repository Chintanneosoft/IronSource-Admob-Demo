//
//  CustomLabel.swift
//  QuizApp
//
//  Created by apple on 22/03/20.
//  Copyright © 2020 iOSAppsWorld. All rights reserved.
//

import UIKit

class ExtraBoldLabel: UILabel {
    override func awakeFromNib() {
        font = UIFont(name: Fonts.ExtraBoldFont!.fontName, size: font.pointSize)
        textColor = .yellow
    }
}

class BoldLabel: UILabel {
    override func awakeFromNib() {
        font = UIFont(name: Fonts.BoldFont!.fontName, size: font.pointSize)
        textColor = Colors.DarkColor
    
    }
}

class BoldWhiteLabel: UILabel {
    override func awakeFromNib() {
        font = UIFont(name: Fonts.BoldFont!.fontName, size: font.pointSize)
        textColor = Colors.LightColor
    }
}

class RegularLabel: UILabel {
    override func awakeFromNib() {
        font = UIFont(name: Fonts.RegularFont!.fontName, size: font.pointSize)
        textColor = Colors.DarkColor
    }
}

class RegularWhiteLabel: UILabel {
    override func awakeFromNib() {
        font = UIFont(name: Fonts.RegularFont!.fontName, size: font.pointSize)
        textColor = .white
    }
}

class SemiBoldLabel: UILabel {
    override func awakeFromNib() {
        font = UIFont(name: Fonts.SemiBoldFont!.fontName, size: font.pointSize)
        textColor = Colors.DarkColor
    }
}


class SemiBoldWhiteLabel: UILabel {
    override func awakeFromNib() {
        font = UIFont(name: Fonts.SemiBoldFont!.fontName, size: font.pointSize)
        textColor = .white
    }
}
