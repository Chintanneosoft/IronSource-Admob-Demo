//
//  DatePickerController.swift
//  Widgets
//
//  Created by Apple on 20/10/20.
//

import Foundation
import UIKit

class DatePickerController: BottomPopupViewController {
    @IBOutlet var datePicker: UIDatePicker!

    var viewLoadedCompletion : ((_ datePicker: UIDatePicker)->Void)!
    var valueChangedCompletion : ((_ date: Date)->Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
        if (self.viewLoadedCompletion != nil) {
            self.viewLoadedCompletion(self.datePicker)
        }
    }

    @IBAction func valueChanged(sender: UIDatePicker) {
        if (self.valueChangedCompletion != nil) {
            self.valueChangedCompletion(sender.date)
            dismissMe()
        }
    }
}
