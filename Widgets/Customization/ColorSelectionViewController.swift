//
//  FontPickerViewController.swift
//  DailyQuotesWidget
//
//  Created by Apple on 13/10/20.
//

import UIKit

protocol ColorSelectionDelegate {
    func colorSelected(_ color: UIColor , type: String?)
}

class ColorSelectionViewController: BottomPopupViewController {
    @IBOutlet weak var colorView: MaterialColorPicker!
    var selectedColor: String?
    var type: String!

    var delegate:ColorSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.delegate = self
        if let selectedColor = selectedColor{
            colorView.selectColor(selectedColor)
        }
        // Do any additional setup after loading the view.
    }
}

extension ColorSelectionViewController: MaterialColorPickerDelegate{
    func didSelectColorAtIndex(_ materialColorPickerView: MaterialColorPicker, index: Int, color: UIColor) {
        delegate?.colorSelected(color, type: self.type)
        dismissMe()
    }
}
