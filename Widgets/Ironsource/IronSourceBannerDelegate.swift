//
//  IronSourceBannerDelegate.swift
//  Widgets
//
//  Created by Neosoft on 14/03/24.
//

import Foundation
import IronSource

class BannerAdDelegate: NSObject, LevelPlayBannerDelegate {
    
    weak var delegate: AdViewControllerDelegate?

    init(delegate: AdViewControllerDelegate!) {
        self.delegate = delegate
    }
    
    func didLoad(_ bannerView: ISBannerView!, with adInfo: ISAdInfo!) {
        logCallbackName(string: "\(#function) adInfo = \(String(describing:adInfo.self))")

        self.delegate?.setAndBindBannerView(bannerView)
    }
    
    func didFailToLoadWithError(_ error: Error!) {
        logCallbackName(string: "\(#function) error = \(String(describing:error.self))")
    }
    
    func didClick(with adInfo: ISAdInfo!) {
        logCallbackName(string: "\(#function) adInfo = \(String(describing:adInfo.self))")
    }
    
    func didLeaveApplication(with adInfo: ISAdInfo!) {
        logCallbackName(string: "\(#function) adInfo = \(String(describing:adInfo.self))")
    }
    
    func didPresentScreen(with adInfo: ISAdInfo!) {
        logCallbackName(string: "\(#function) adInfo = \(String(describing:adInfo.self))")
    }
    
    func didDismissScreen(with adInfo: ISAdInfo!) {
        logCallbackName(string: "\(#function) adInfo = \(String(describing:adInfo.self))")
    }
    
    //MARK: Helper Method
    func logCallbackName(string: String = #function) {
        print("DemoBannerAdDelegate \(string)")
    }
}

