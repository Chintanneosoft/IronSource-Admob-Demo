//
//  BannerView.swift
//  Widgets
//
//  Created by Neosoft on 15/03/24.
//

import Foundation
import IronSource
import UIKit
class BannerViewController: UIViewController {
    private var bannerView: ISBannerView?
    private var bannerDelegate: BannerAdDelegate! = nil
    private let appId = "1dd4517e5"
    private var initializationDelegate: InitializationDelegate!
    
    // MARK: - set Banner
    func setBanner(){
        IronSource.initWithAppKey(appId, delegate: initializationDelegate)
        bannerDelegate = .init(delegate: self)
        IronSource.setLevelPlayBannerDelegate(bannerDelegate)
        IronSource.setAdaptersDebug(true)
        showBanner()
    }
    // MARK: - Show Banner
    private func showBanner(){
        if bannerView != nil {
            destroyBanner()
        }
        //Banner Size
        let bannerSize: ISBannerSize = ISBannerSize(description:kSizeBanner, width:320, height:50)
        //Load Banner
        IronSource.loadBanner(with: self, size: bannerSize)
    }
    
    func destroyBanner() {
        DispatchQueue.main.async {
            if let bannerObj = self.bannerView {
                bannerObj.removeFromSuperview()
                IronSource.destroyBanner(bannerObj)
                self.bannerView = nil
            }
        }
    }
}
//MARK: - Set Banner View in screen
extension BannerViewController: AdViewControllerDelegate {
    func setAndBindBannerView(_ bannerView: ISBannerView!) {
        DispatchQueue.main.async {
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(bannerView)
            let centerX = bannerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            let bottom = bannerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            let width = bannerView.widthAnchor.constraint(equalToConstant: bannerView.frame.size.width)
            let height = bannerView.heightAnchor.constraint(equalToConstant: bannerView.frame.size.height)
            NSLayoutConstraint.activate([centerX, bottom, width, height])
            self.bannerView = bannerView
        }
    }
}
