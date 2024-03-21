//
//  IronSourceInitDelegate.swift
//  Widgets
//
//  Created by Neosoft on 14/03/24.
//
import Foundation
import IronSource

class InitializationDelegate: NSObject, ISInitializationDelegate {
    
    weak var delegate: AdViewControllerDelegate?

    init(delegate: AdViewControllerDelegate!) {
        self.delegate = delegate
    }
    
    func initializationDidComplete() {
        print("DemoInitializationDelegate \(#function)")
    }
}
