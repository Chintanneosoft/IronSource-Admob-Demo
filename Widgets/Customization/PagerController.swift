//
//  PagerController.swift
//  DTPagerController
//
//  Created by tungvoduc on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import DTPagerController
import UIKit

class PagerController: DTPagerController {
    init() {
        super.init(viewControllers: [])
        title = "PagerController"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageSelectionDeleagte:BackgroundsViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        perferredScrollIndicatorHeight = 4

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let colorView = storyboard.instantiateViewController(withIdentifier: "ColorSelectionViewController") as! ColorSelectionViewController
        colorView.title = "Color"
        colorView.delegate = self
        
        let gradientView = storyboard.instantiateViewController(withIdentifier: "GradientSelectionViewController") as! GradientSelectionViewController
        gradientView.title = "Gradient"
        gradientView.delegate = self

        let localImages = storyboard.instantiateViewController(withIdentifier: "BackgroundsViewController") as! BackgroundsViewController
        
        localImages.title = "Local"
        localImages.delegate = self
        
        let flickerImages = storyboard.instantiateViewController(withIdentifier: "ImageSearchController") as! ImageSearchController
        
        flickerImages.title = "Flicker"
        flickerImages.delegate = self
        
        let unsplashPhotoPicker = UnsplashPhotoPickerViewController()
        unsplashPhotoPicker.title = "Unsplash"
        unsplashPhotoPicker.imageSelectionDelegate = self

        viewControllers = [colorView, gradientView]
        scrollIndicator.backgroundColor = UIColor.white
        scrollIndicator.layer.cornerRadius = scrollIndicator.frame.height / 2

        setSelectedPageIndex(0, animated: false)

        pageSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        pageSegmentedControl.backgroundColor = .black
        pageSegmentedControl.layer.masksToBounds = false
        pageSegmentedControl.layer.shadowColor = UIColor.lightGray.cgColor
        pageSegmentedControl.layer.shadowOffset = CGSize(width: 0, height: 1)
        pageSegmentedControl.layer.shadowRadius = 1
        pageSegmentedControl.layer.shadowOpacity = 0.5
    }
}

// MARK: - UnsplashPhotoPickerDelegate

extension PagerController: ColorSelectionDelegate{
    func colorSelected(_ color: UIColor, type: String?) {
        let image = UIImage.from(color: color)
        imageSelectionDeleagte?.backgroundSelected(image)
        dismissMe()
    }
}

extension PagerController: GradientSelectionDelegate{
    func gradientSelected(_ gradient: Int) {
        let gradientLayer = Gradients.init(rawValue: gradient + 1)!.layer
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 500, height: 500)

        let image = UIImage.imageFromLayer(layer: gradientLayer)
        imageSelectionDeleagte?.backgroundSelected(image)
        dismissMe()

    }
}

extension PagerController: BackgroundsViewDelegate{
    func backgroundSelected(_ image: UIImage) {
        imageSelectionDeleagte?.backgroundSelected(image)
        dismissMe()
    }
}
