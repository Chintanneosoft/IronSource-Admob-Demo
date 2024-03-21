//
//  GMPalette.swift
//  GMColor
//
//  Created by Todsaporn Banjerdkit (katopz) on 12/22/14.
//  Copyright (c) 2014 Debokeh. All rights reserved.
//

import UIKit

public struct FontsList {

   static func all() -> [String] {
    return ["Alba","AlbaMatter","AlbaSuper","AlexBrush-Regular","Allura-Regular","AmericanCaptain","BrightonsRegular","CameronSansLight","CameronSansBold","DancingScript","DancingScript-Bold","DenseLettersRegular","Franky","Junegull","KakkoiRegular","KindsonFree","Landasans-UltraLight","Landasans-Medium","LilyScriptOne-Regular","Manhandle-Slab","Momcake-Bold","MonoglycerideExtraBold","Monserga","Montserrat-Regular","Montserrat-Italic","Montserrat-Thin","Montserrat-ThinItalic","Montserrat-ExtraLight","Montserrat-ExtraLightItalic","Montserrat-Light","Montserrat-LightItalic","Montserrat-Medium","Montserrat-MediumItalic","Montserrat-SemiBold","Montserrat-SemiBoldItalic","Montserrat-Bold","Montserrat-BoldItalic","Montserrat-ExtraBold","Montserrat-ExtraBoldItalic","Montserrat-Black","Montserrat-BlackItalic","Optien","Organocoloredversionat:logomagazin.comorgano-font","RockoFLF","RockoFLF-Bold","RockoUltraFLF","RockoUltraFLF-Bold","SkatersDemo","Teen-Italic","TeenLight-Italic","Teen-Bold","Teen-BoldItalic","TheDelicateDEMO","TypoRound-ItalicDemo","TypoRound-ThinItalicDemo","TypoRound-LightItalicDemo","TypoRound-BoldItalicDemo","TypoRoundBoldDemo","TypoRoundLightDemo","TypoRoundRegularDemo","TypoRoundThinDemo","TypoGraphica","YoureInvited"]
  }
  
  public static func allFonts()->[String]{
    var fonts = [String]()
    for font in all(){
        fonts.append(font)
    }
    return fonts
  }
}
