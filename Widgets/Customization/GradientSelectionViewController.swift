//
//  FontPickerViewController.swift
//  DailyQuotesWidget
//
//  Created by Apple on 13/10/20.
//

import UIKit

protocol GradientSelectionDelegate {
    func gradientSelected(_ gradient: Int)
}

class GradientSelectionViewController: BottomPopupViewController {
    @IBOutlet weak var colorView: GradientColorPicker!
    var selectedGradient: Int?
    
    var delegate:GradientSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.delegate = self
        if let selectedGradient = selectedGradient{
            colorView.selectColorIndex(selectedGradient)
        }
        // Do any additional setup after loading the view.
    }
}

extension GradientSelectionViewController: GradientColorPickerDelegate{
    func didSelectGradientColorAtIndex(_ gradientColorPickerView: GradientColorPicker, index: Int, color: UIColor) {
        delegate?.gradientSelected(index)
        dismissMe()

    }
}
