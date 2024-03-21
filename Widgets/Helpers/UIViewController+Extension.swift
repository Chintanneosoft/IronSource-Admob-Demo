//
//  UIViewController+Extension.swift
//  SeeSaw
//
//  Created by apple on 09/01/20.
//  Copyright © 2020 Sherry. All rights reserved.
//

import UIKit
import Loaf
import NVActivityIndicatorView

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissTheKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissTheKeyboard() {
        view.endEditing(true)
    }
    
    func showAlertMessage(title: String, message: String? = "Please try again later") {
        DispatchQueue.main.async {
            Loaf(message!, state: .success, sender: self).show()
        }
    }
    
    func present(_ viewCon: UIViewController) {
        present(viewCon, animated: true, completion: nil)
    }
        
    func push(_ viewCon: UIViewController) {
        navigationController?.pushViewController(viewCon, animated: true)
    }
    
    func pushFromTab(_ viewCon: UIViewController) {
        tabBarController?.navigationController?.pushViewController(viewCon, animated: true)
    }

    func pop() {
        navigationController?.popViewController(animated: true)
    }
        
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
     
    @IBAction func back()  {
        navigationController?.popViewController(animated: true)
    }
        
    @IBAction func dismissMe()  {
        dismiss(animated: true, completion: nil)
    }
        
    func showLoaderView() {
        LoaderView.shared.showOnView()
    }
           
    func hideLoaderView(){
        LoaderView.shared.hideFromView()
    }
        
    func showMessage(message: String, header:String?)  {
        DispatchQueue.main.async {
            Loaf(message, state: .success, sender: self).show()
        }
    }
        
    func showHardErrorMessage(message: String?, header:String?)  {
        DispatchQueue.main.async {
            Loaf(message ?? "There is some problem, please try again later", state: .error, sender: self).show()
        }
    }
        
    func showSoftError(message: String)  {
        DispatchQueue.main.async {
            Loaf(message, state: .warning, sender: self).show()
        }
    }
        
    func showTryAgainMessage()  {
        DispatchQueue.main.async {
            Loaf("There is some problem right now, please try again later", state: .error, sender: self).show()
        }
    }
}

class LoaderView: UIViewController, NVActivityIndicatorViewable {
    static let shared = LoaderView()
    func showOnView() {
        let size = CGSize(width: 60.0, height: 60.0)
        startAnimating(size, type: .circleStrokeSpin , color: .red)
    }
    
    func hideFromView() {
        stopAnimating()
    }
}

extension UIViewController {

    var hasSafeArea: Bool {
        guard
            #available(iOS 11.0, tvOS 11.0, *)
            else {
                return false
            }
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }

}
