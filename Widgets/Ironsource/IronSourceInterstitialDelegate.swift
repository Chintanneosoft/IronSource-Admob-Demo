//
//  IronSourceInterstitialDelegate.swift
//  Widgets
//
//  Created by Neosoft on 14/03/24.
//

import Foundation
import IronSource

class IntertitialDelegate: NSObject, LevelPlayInterstitialDelegate {
    
    weak var delegate: AdViewControllerDelegate?

    init(delegate: AdViewControllerDelegate!) {
        self.delegate = delegate
    }
    
    func didLoad(with adInfo: ISAdInfo) {
        print(#function)
    }
    
    func didFailToLoadWithError(_ error: Error!) {
        
            print(#function)
    }
    
    func didOpen(with adInfo: ISAdInfo!) {
        
            print(#function)
    }
    
    func didShow(with adInfo: ISAdInfo!) {
        
            print(#function)
    }
    
    func didFailToShowWithError(_ error: Error!, andAdInfo adInfo: ISAdInfo!) {
        
            print(#function)
    }
    
    func didClick(with adInfo: ISAdInfo!) {
        
            print(#function)
    }
    
    func didClose(with adInfo: ISAdInfo!) {
        
            print(#function)
    }
    
    //MARK: Helper Method
    
    func logCallbackName(string: String = #function) {
        
            print(#function)
    }
}
