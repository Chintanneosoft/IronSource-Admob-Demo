//
//  FontPickerViewController.swift
//  DailyQuotesWidget
//
//  Created by Apple on 13/10/20.
//

import UIKit

protocol FontSelectionDelegate {
    func fontSelected(_ font: String)
}

class FontPickerViewController: BottomPopupViewController {
    @IBOutlet weak var fontView: FontPicker!
    var selectedFont: String?
    
    var delegate:FontSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontView.delegate = self
        if let selectedFont = selectedFont{
            fontView.selectFont(selectedFont)
        }
        // Do any additional setup after loading the view.
    }
}

extension FontPickerViewController: FontPickerDelegate{
    func didSelectFontAtIndex(_ fontPickerView: FontPicker, index: Int, font: String) {
        self.delegate?.fontSelected(font)
        dismissMe()
    }
}
