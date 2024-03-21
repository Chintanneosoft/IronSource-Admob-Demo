//
//  HowToViewController.swift
//  Widgets
//
//  Created by Apple on 23/10/20.
//

import UIKit
import IronSource

class HowToViewController: BannerViewController {
    
    @IBOutlet weak var viewStep1: UIView!
    @IBOutlet weak var viewStep2: UIView!
    @IBOutlet weak var viewStep3: UIView!
    @IBOutlet weak var viewStep4: UIView!
    @IBOutlet weak var viewStep5: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var viewBg: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 1, animations: {
            self.stackView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                self.stackView.transform = CGAffineTransform.identity
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBanner()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        destroyBanner()
    }

}


extension UIView {
   func roundCornersTop(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
