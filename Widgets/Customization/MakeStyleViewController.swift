//
//  MakeStyleViewController.swift
//  DailyQuotesWidget
//
//  Created by Apple on 07/10/20.
//

import UIKit
import WidgetKit
import CoreData

class MakeStyleViewController: UIViewController {
    @IBOutlet weak var templateCollection: TemplateCollectionView!

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var fontPickerView: FontPicker!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var quotesPref: UILabel!
    @IBOutlet weak var fontLabel: UILabel!

    @IBOutlet weak var textColorIndicatorView: UIView!
    @IBOutlet weak var backgroundIndicatorImageView: UIImageView!
    @IBOutlet weak var overlayIndicatorView: UIView!
    @IBOutlet weak var borderIndicatorView: UIView!

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var fontSegmentControl: UISegmentedControl!
    @IBOutlet weak var textColorSegmentControl: UISegmentedControl!

    @IBOutlet weak var overlayAlphaSlider: UISlider!
    @IBOutlet weak var borderSizeSlider: UISlider!
    @IBOutlet weak var textColorAlphaSlider: UISlider!

    //editing options view
    @IBOutlet weak var quotesSelectionView: UIView!
    @IBOutlet weak var textAlignmentView: UIView!
    @IBOutlet weak var headingFontSelectionView: UIView!

    @IBOutlet weak var headingTextColorSelectionView: UIView!

    @IBOutlet weak var backgroundSelectionView: UIView!
    @IBOutlet weak var overlaySelectionView: UIView!
    @IBOutlet weak var borderSelectionView: UIView!
    @IBOutlet weak var reminderTypeInputView: UIView!
    @IBOutlet weak var reminderDateView: UIView!
    @IBOutlet weak var photoSelectionView: UIView!

    @IBOutlet weak var enterMessageTextLabel: UILabel!
    @IBOutlet weak var selectDateLabel: UILabel!
    @IBOutlet weak var enterMessageTF: UITextField!
    @IBOutlet weak var eventDateBtn: UIButton!
    @IBOutlet weak var selectedImagesCountLabel: UILabel!
    
    @IBOutlet weak var btnSaveWidget: FilledButton!
    @IBOutlet weak var templateCollectionHeight: NSLayoutConstraint!

    var widgetName: String?
    var templateId: String?
    var eventDate: Date?
    
    var index = 0
    var nameWid = ""
    

    var widget: WidgetCollection?
    let context = CoreDataStorage.mainQueueContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSaveWidget.layer.shadowRadius = 4
        btnSaveWidget.layer.shadowOpacity = 1.0
        btnSaveWidget.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btnSaveWidget.layer.shadowColor = UIColor.white.cgColor
        btnSaveWidget.layer.cornerRadius = 20
        //btnSaveWidget.backgroundColor = UIColor.white
        //btnSaveWidget.setTitleColor(UIColor.orange, for: .normal)
        fontLabel.backgroundColor = UIColor.white
        fontLabel.textColor = UIColor(named: "DarkColor")
        scrollView.backgroundColor = UIColor(named: "DarkColor")//UIColor(hexString: "#FF6C79")
        fontPickerView.delegate = self
        
        templateCollection.register(CalendarTemplateCollectionViewCell.self, forCellWithReuseIdentifier: CalendarTemplateCollectionViewCell.identifier)

        textColorIndicatorView.roundAndBorder()
        backgroundIndicatorImageView.roundAndBorder()
        overlayIndicatorView.roundAndBorder()
        borderIndicatorView.roundAndBorder()
        view.backgroundColor = UIColor.white
        setupView()
        
        UIView.animate(withDuration: 0, animations: {
            self.stackView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                self.stackView.transform = CGAffineTransform.identity
            })
        }
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let widgetMaxSize = Dimentions.getWidgetSizeFor("large")
        templateCollectionHeight.constant = widgetMaxSize.height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if widget?.name == nil{
            context.delete(widget!)
        }
    }
    
    func setupView(){
//        textAlignmentView.removeFromSuperview()
//        if widget?.type == WidgetType.calendar.rawValue{
            quotesSelectionView.removeFromSuperview()
//            reminderTypeInputView.removeFromSuperview()
//            reminderDateView.removeFromSuperview()
//            photoSelectionView.removeFromSuperview()
            fontSegmentControl.removeSegment(at: 2, animated: true)
            textColorSegmentControl.removeSegment(at: 2, animated: true)
//        }
//        else if widget?.type == WidgetType.quote.rawValue{
//            reminderTypeInputView.removeFromSuperview()
//            reminderDateView.removeFromSuperview()
//            photoSelectionView.removeFromSuperview()
//        }
//        else if widget?.type == WidgetType.photo.rawValue{
//            quotesSelectionView.removeFromSuperview()
//            reminderTypeInputView.removeFromSuperview()
//            reminderDateView.removeFromSuperview()
//            textAlignmentView.removeFromSuperview()
//            headingFontSelectionView.removeFromSuperview()
//            headingTextColorSelectionView.removeFromSuperview()
//            backgroundSelectionView.removeFromSuperview()
//            overlaySelectionView.removeFromSuperview()
//        }
//        else if widget?.type == WidgetType.reminder.rawValue{
//            quotesSelectionView.removeFromSuperview()
//            photoSelectionView.removeFromSuperview()
//
//            enterMessageTF.text = widget?.headingText
//
//            if let dueDate = widget?.dueDate{
//                eventDateBtn.setTitle(dueDate.toString(format: "dd-MMM-yyyy"), for: .normal)
//            }
//            else{
//                eventDateBtn.setTitle(Date().toString(format: "dd-MMM-yyyy"), for: .normal)
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadStyle()
    }
    
    func reloadStyle() {
        WidgetCenter.shared.reloadAllTimelines()
        
        if widget?.type == WidgetType.quote.rawValue{
            let selectedQuotes = widget?.quotes?.array() ?? []
            var allQuotesType : [String] = []
            
            for quote in selectedQuotes{
                let fileName = (quote["value"])!
                allQuotesType.append(fileName as! String)
            }
            
            quotesPref.text = allQuotesType.joined(separator: ",")
        }
        
        
        
        
        let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupId)
        let imagePath = (documentsDirectory?.appendingPathComponent("\(widget?.id ?? "widget")-bgImage.png"))!
        
        if let image = UIImage(contentsOfFile: imagePath.path){
            backgroundIndicatorImageView.image =  image
        }
        else{
            let image = UIImage(named: (widget?.background)!)
            try! image?.pngData()?.write(to: imagePath)
            backgroundIndicatorImageView.image =  image
        }
        
        if let selectedFont = widget?.headingLabelFont{
            fontLabel.text = selectedFont
            fontLabel.font = UIFont(name: selectedFont, size: 15)
            fontPickerView.selectFont(selectedFont)
        }
        
        if let selectedColor = widget?.headingLabelTextColor{
            let textColor = UIColor.hexStringToUIColor(hex: selectedColor)
            textColorIndicatorView.backgroundColor = textColor
            
            let textAlpha = widget?.headingLabelTextAlpha ?? 0
            textColorAlphaSlider.value = Float(textAlpha)
        }
        
        if let selectedColor = widget?.overlayColor{
            overlayIndicatorView.backgroundColor = UIColor.hexStringToUIColor(hex: selectedColor)
            let overlayAlpha = widget?.overlayAlpha ?? 0
            overlayAlphaSlider.value = Float(overlayAlpha)
        }
        
        if let selectedColor = widget?.borderColor{
            let borderSize = widget?.borderWidth ?? 0.0

            borderIndicatorView.backgroundColor = UIColor.hexStringToUIColor(hex: selectedColor)
            borderSizeSlider.value = Float(borderSize)
        }
        
        if let align = widget?.textAlignment{
            switch align {
            case "left":
                segmentControl.selectedSegmentIndex = 0
            case "center":
                segmentControl.selectedSegmentIndex = 1
            case "right":
                segmentControl.selectedSegmentIndex = 2
            default:
                print("")
            }
        }
    }

    @IBAction func segmentChanged(_ segmentControl: UISegmentedControl){
        switch segmentControl.selectedSegmentIndex {
        case 0:
            widget?.textAlignment = "left"
        case 1:
            widget?.textAlignment = "center"
        case 2:
            widget?.textAlignment = "right"
        default:
            print("")
        }
    }
    
    @IBAction func selectTextColorBtnClicked(){
        if let colorView = self.storyboard?.instantiateViewController(withIdentifier: "ColorSelectionViewController") as? ColorSelectionViewController{
            if let selectedColor = widget?.headingLabelTextColor{
                colorView.selectedColor = selectedColor
            }
            colorView.type = "textColor"
            colorView.delegate = self
            present(colorView)
        }
    }
    
    @IBAction func selectQuotesBtnClicked(){
        if let quotesView = self.storyboard?.instantiateViewController(withIdentifier: "QuoteCategoryTableViewController") as? QuoteCategoryTableViewController{
            quotesView.delegate = self
            present(quotesView)
        }
    }
    
//    @IBAction func selectFontBtnClicked(){
//        if let fontView = self.storyboard?.instantiateViewController(withIdentifier: "FontPickerViewController") as? FontPickerViewController{
//            if let selectedFont = widget?.headingLabelFont{
//                fontView.selectedFont = selectedFont
//            }
//            fontView.delegate = self
//
//            present(fontView)
//        }
//    }
    
    @IBAction func selectBorderColorBtnClicked(){
        if let colorView = self.storyboard?.instantiateViewController(withIdentifier: "ColorSelectionViewController") as? ColorSelectionViewController{
            if let selectedColor = widget?.headingLabelTextColor{
                colorView.selectedColor = selectedColor
            }
            colorView.type = "borderColor"
            colorView.delegate = self

            present(colorView)
        }
    }
    
    @IBAction func selectOverlayColorBtnClicked(){
        if let colorView = self.storyboard?.instantiateViewController(withIdentifier: "ColorSelectionViewController") as? ColorSelectionViewController{
            if let selectedColor = widget?.headingLabelTextColor{
                colorView.selectedColor = selectedColor
            }
            colorView.type = "overlayColor"
            colorView.delegate = self
            present(colorView)
        }
    }
    
    @IBAction func backgroundBtnClicked(){
        let bgView = PagerController()
        bgView.imageSelectionDeleagte = self
        present(bgView)
    }
    
    @IBAction func borderSizeSliderChange(_ slider: UISlider){
        if let selectedColor = widget?.borderColor{
            widget?.borderWidth = Double(slider.value)
            borderIndicatorView.backgroundColor = UIColor.hexStringToUIColor(hex: selectedColor).withAlphaComponent(CGFloat(borderSizeSlider.value))
        }
        templateCollection.reloadData()
    }
    
    @IBAction func overlaySliderChange(_ slider: UISlider){
        if let overlayViewColorString = widget?.overlayColor{
            let overlayViewColor = UIColor.hexStringToUIColor(hex: overlayViewColorString)
            overlayIndicatorView.backgroundColor = overlayViewColor.withAlphaComponent(CGFloat(slider.value))

            widget?.overlayAlpha = Double(slider.value)
        }
        templateCollection.reloadData()
    }
    
    @IBAction func textColorAlphaSliderChange(_ slider: UISlider){
        switch textColorSegmentControl.selectedSegmentIndex {
        case 0:
            if let selectedColor = widget?.headingLabelTextColor{
                let textColor = UIColor.hexStringToUIColor(hex: selectedColor).withAlphaComponent(CGFloat(slider.value))
                textColorIndicatorView.backgroundColor = textColor
                widget?.headingLabelTextAlpha = Double(slider.value)
            }
        case 1:
            if let selectedColor = widget?.subHeadingLabelTextColor{
                let textColor = UIColor.hexStringToUIColor(hex: selectedColor).withAlphaComponent(CGFloat(slider.value))
                textColorIndicatorView.backgroundColor = textColor
                widget?.subHeadingLabeTextAlpha = Double(slider.value)
            }
        case 2:
            if let selectedColor = widget?.subHeadingLabel2TextColor{
                let textColor = UIColor.hexStringToUIColor(hex: selectedColor).withAlphaComponent(CGFloat(slider.value))
                textColorIndicatorView.backgroundColor = textColor
                widget?.subHeadingLabel2TextAlpha = Double(slider.value)
            }
        default:
            print("no action")
        }
        
        templateCollection.reloadData()
    }
    
    
    @IBAction func settingBtnClicked(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let makeStyleView = storyboard.instantiateViewController(withIdentifier: "ManagePurchaseViewController") as? ManagePurchaseViewController
        self.navigationController?.pushViewController(makeStyleView!, animated: true)
    }
    
    @IBAction func resetFontBtnClicked(){
        widget?.headingLabelFont = "HerbertLemuelBold"
        templateCollection.reloadData()
    }
    
    @IBAction func resetTextColorBtnClicked(){
        widget?.headingLabelTextColor = UIColor.blue.hexStringFromColor()
        widget?.subHeadingLabelTextColor = UIColor.blue.hexStringFromColor()
        widget?.subHeadingLabel2TextColor = UIColor.blue.hexStringFromColor()
        templateCollection.reloadData()
    }
    
    @IBAction func resetOverlayColorBtnClicked(){
        widget?.overlayColor = UIColor.white.hexStringFromColor()
        widget?.overlayAlpha = 0
        templateCollection.reloadData()
    }
    
    @IBAction func resetBorderColorBtnClicked(){
        widget?.borderColor = UIColor.white.hexStringFromColor()
        widget?.borderWidth = 0
        templateCollection.reloadData()
    }
    
    @IBAction func resetBgBtnClicked(){
        let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupId)
        let imagePath = (documentsDirectory?.appendingPathComponent("\(widget?.id ?? "widget")-bgImage.png"))!
        try! UIImage.from(color: .white).pngData()?.write(to: imagePath)

        backgroundIndicatorImageView.image = nil
        widget?.background = imagePath.path
        templateCollection.reloadData()
    }
    
    @IBAction func saveWidget(){
        if let enterMessageTF = enterMessageTF{
            if enterMessageTF.text?.isEmpty == true || enterMessageTF.text == nil{
                showAlertMessage(title: "Please enter message")
                return;
            }
            widget?.headingText = enterMessageTF.text
        }
        
        if reminderDateView != nil{
            if self.widget?.dueDate == nil{
                showAlertMessage(title: "Please enter event date")
                return;
            }
            widget?.headingText = enterMessageTF.text
        }
        
        func save(){
            do {
                try context.save()
                WidgetCenter.shared.reloadAllTimelines()
                pop()
            } catch {
                print("Failed saving")
            }
        }
        
        func askForName(){
            let ac = UIAlertController(title: "Enter widget name", message: nil, preferredStyle: .alert)
            ac.addTextField()

            let submitAction = UIAlertAction(title: "OK", style: .default) { [unowned ac] _ in
                let name = ac.textFields![0]
                if name.text == nil || name.text?.isEmpty == true{
                    askForName()
                }
                else{
                    self.widget?.name = name.text
                    
                    save()
                }
            }
            ac.addAction(submitAction)
            present(ac, animated: true)
        }
        
        
       
        
//
//        if widget?.name == nil{
//            askForName()
//        }
//        else{
            
        self.widget?.name = widgetName
        showMessage(message: "Added", header: "Added")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            save()
            
        }
       
        
        
       // }
        
        
    }
    
    @IBAction func selectEventDate(){
        if let datePickerController : DatePickerController = storyboard?.instantiateViewController(withIdentifier: "DatePickerController") as? DatePickerController {
            
            datePickerController.valueChangedCompletion = { date in
                self.widget?.dueDate = date
                self.eventDateBtn.setTitle(date.toString(format: "dd-MMM-yyyy"), for: .normal)
            }
            
            present(datePickerController)
        }
    }
    
    @IBAction func fontSegmentChanged(_ segment: UISegmentedControl){
        switch segment.selectedSegmentIndex {
        case 0:
            if let selectedFont = widget?.headingLabelFont{
                fontLabel.text = selectedFont
                fontLabel.font = UIFont(name: selectedFont, size: 15)
                fontPickerView.selectFont(selectedFont)
            }
        case 1:
            if let selectedFont = widget?.subHeadingLabelFont{
                fontLabel.text = selectedFont
                fontLabel.font = UIFont(name: selectedFont, size: 15)
                fontPickerView.selectFont(selectedFont)
            }
        case 2:
            if let selectedFont = widget?.subHeadingLabel2Font{
                fontLabel.text = selectedFont
                fontLabel.font = UIFont(name: selectedFont, size: 15)
                fontPickerView.selectFont(selectedFont)
            }
        default:
            print("no action")
        }
    }
    
    @IBAction func textColorSegmentChanged(_ segment: UISegmentedControl){
        switch segment.selectedSegmentIndex {
        case 0:
            if let selectedColor = widget?.headingLabelTextColor{
                let textColor = UIColor.hexStringToUIColor(hex: selectedColor)
                textColorIndicatorView.backgroundColor = textColor
                textColorAlphaSlider.value = Float(widget?.headingLabelTextAlpha ?? 1)
            }
        case 1:
            if let selectedColor = widget?.subHeadingLabelTextColor{
                let textColor = UIColor.hexStringToUIColor(hex: selectedColor)
                textColorIndicatorView.backgroundColor = textColor
                textColorAlphaSlider.value = Float(widget?.subHeadingLabeTextAlpha ?? 1)
            }
        case 2:
            if let selectedColor = widget?.subHeadingLabel2TextColor{
                let textColor = UIColor.hexStringToUIColor(hex: selectedColor)
                textColorIndicatorView.backgroundColor = textColor
                textColorAlphaSlider.value = Float(widget?.subHeadingLabel2TextAlpha ?? 1)
            }
        default:
            print("no action")
        }
    }
}

extension MakeStyleViewController: FontPickerDelegate{
    func didSelectFontAtIndex(_ fontPickerView: FontPicker, index: Int, font: String) {
        switch fontSegmentControl.selectedSegmentIndex {
        case 0:
            widget?.headingLabelFont = font
        case 1:
            widget?.subHeadingLabelFont = font
        case 2:
            widget?.subHeadingLabel2Font = font
        default:
            print("no action")
        }
        
        fontLabel.text = font
        fontLabel.font = UIFont(name: font, size: 15)
        
        templateCollection.reloadData()
    }
    
//    func fontSelected(_ font: String) {
//
//    }
}

extension MakeStyleViewController: ColorSelectionDelegate{
    func colorSelected(_ color: UIColor , type: String?) {
        if type == "textColor"{
            
            switch textColorSegmentControl.selectedSegmentIndex {
            case 0:
                widget?.headingLabelTextColor = color.hexStringFromColor()
            case 1:
                widget?.subHeadingLabelTextColor = color.hexStringFromColor()
            case 2:
                widget?.subHeadingLabel2TextColor = color.hexStringFromColor()
            default:
                print("no action")
            }
            
            textColorIndicatorView.backgroundColor = color
        }
        else if type == "overlayColor"{
            widget?.overlayColor = color.hexStringFromColor()
            overlayIndicatorView.backgroundColor = color.withAlphaComponent(CGFloat(overlayAlphaSlider.value))
        }
        else if type == "borderColor"{
            widget?.borderColor = color.hexStringFromColor()
            borderIndicatorView.backgroundColor = color.withAlphaComponent(CGFloat(borderSizeSlider.value))
        }
        
        templateCollection.reloadData()
    }
}

extension MakeStyleViewController: QuoteCategoryTableDelegate{
    func quotesSelectionUpdate(_ quotes: [[String:String]]) {
        widget?.quotes = quotes.json()
        
        let selectedQuotes = quotes
        var allQuotesType : [String] = []
        
        for quote in selectedQuotes{
            let fileName = (quote["value"])!
            allQuotesType.append(fileName )
        }
        
        quotesPref.text = allQuotesType.joined(separator: ",")
    }
}

extension MakeStyleViewController: BackgroundsViewDelegate{
    func backgroundSelected(_ image: UIImage) {
        backgroundIndicatorImageView.image = image
        
        let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupId)
        let imagePath = (documentsDirectory?.appendingPathComponent("\(widget?.id ?? "widget")-bgImage.png"))!
        
        try! image.pngData()?.write(to: imagePath)
        
        widget?.background = imagePath.path
        templateCollection.reloadData()
    }
}

extension MakeStyleViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionView  =  collectionView as? TemplateCollectionView else { return UICollectionViewCell() }

//        if widget?.type == WidgetType.calendar.rawValue{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarTemplateCollectionViewCell.identifier, for: indexPath) as? CalendarTemplateCollectionViewCell
            let calendarTemplate = TemplateWidget(widget: widget!)
            
            if indexPath.section == 0{
                cell?.setItem(calendarTemplate, sizeType: "small", canDelete: false)
            }
            if indexPath.section == 1{
                cell?.setItem(calendarTemplate, sizeType: "medium", canDelete: false)
            }
            if indexPath.section == 2{
                cell?.setItem(calendarTemplate, sizeType: "large", canDelete: false)
            }
            
            return cell!
//        }
//        else if widget?.type == WidgetType.quote.rawValue{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteTemplateCollectionViewCell.identifier, for: indexPath) as? QuoteTemplateCollectionViewCell
//            let calendarTemplate = TemplateWidget(widget: widget!)
//
//            if indexPath.section == 0{
//                cell?.setItem(calendarTemplate, sizeType: "small", canDelete: false)
//            }
//            if indexPath.section == 1{
//                cell?.setItem(calendarTemplate, sizeType: "medium", canDelete: false)
//            }
//            if indexPath.section == 2{
//                cell?.setItem(calendarTemplate, sizeType: "large", canDelete: false)
//            }
//
//            return cell!
//        }
//        else{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReminderTemplateCollectionViewCell.identifier, for: indexPath) as? ReminderTemplateCollectionViewCell
//
//            let reminderTemplate = TemplateWidget(widget: widget!)
//
//            if indexPath.section == 0{
//                cell?.setItem(reminderTemplate, sizeType: "small" , canDelete: false)
//            }
//            if indexPath.section == 1{
//                cell?.setItem(reminderTemplate, sizeType: "medium" , canDelete: false)
//            }
//            if indexPath.section == 2{
//                cell?.setItem(reminderTemplate, sizeType: "large" , canDelete: false)
//            }
//
//            return cell!
//        }
//        return cell!
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//        UIView.animate(withDuration: 0.9, animations: {
//               cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
//               },completion: { finished in
//                UIView.animate(withDuration: 0.1, animations: {
//                       cell.layer.transform = CATransform3DMakeScale(1,1,1)
//                   })
//           })
//
//    }
    
    
}

extension MakeStyleViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0{
            let widgetMaxSize = Dimentions.getWidgetSizeFor("small")
            return CGSize(width: widgetMaxSize.width , height: widgetMaxSize.height )
        }
        else if indexPath.section == 1{
            let widgetMaxSize = Dimentions.getWidgetSizeFor("medium")
            return CGSize(width: widgetMaxSize.width, height: widgetMaxSize.height )
        }
        else{
            let widgetMaxSize = Dimentions.getWidgetSizeFor("large")
            return CGSize(width: widgetMaxSize.width - 50, height: widgetMaxSize.height - 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 50, left: 100, bottom: 0, right: 0)
        }
        if section == 1{
            return UIEdgeInsets(top: 50, left: 40, bottom: 0, right: 0)
        }
        
        return UIEdgeInsets(top: 25, left: 40, bottom: 0, right: 40)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

