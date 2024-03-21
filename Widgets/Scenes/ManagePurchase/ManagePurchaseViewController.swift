//
//  ManagePurchaseViewController.swift
//  FMPhotoPickerExample
//
//  Created by Apple on 14/09/20.
//  Copyright © 2020 Tribal Media House. All rights reserved.
//

import UIKit
import StoreKit
import IronSource

class ManagePurchaseViewController: BannerViewController {
    
    
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var btnShareApp: FilledButton!
    
    @IBOutlet weak var btnWriteReview: FilledButton!
    
    @IBOutlet weak var btnPrivacyPolicy: FilledButton!
    
    @IBOutlet weak var btnAboutUs: FilledButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        btnAboutUs.dropShadow()
        btnPrivacyPolicy.dropShadow()
        btnWriteReview.dropShadow()
        btnShareApp.dropShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBanner()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        destroyBanner()
    }


    @IBAction func shareBtnClicked(){
        let items = [Constants.shareAppMessage]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @IBAction func rateBtnClicked(){
        if let scene = UIApplication.shared.currentScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    @IBAction func policyBtnClicked(){
        if let url = URL(string: Constants.policyURL) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func termsBtnClicked(){
        if let url = URL(string: Constants.termsURL) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func aboutBtnClicked(){
        if let url = URL(string: Constants.aboutURL) {
            UIApplication.shared.open(url)
        }
    }
    
}

