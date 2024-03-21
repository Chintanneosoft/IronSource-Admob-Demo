//
//  PreviewWidgetViewController.swift
//  Widgets
//
//  Created by Apple on 20/10/20.
//

import UIKit

typealias editSelection = (() -> Void)?

class PreviewWidgetViewController: BottomPopupViewController {
    @IBOutlet weak var templateCollection: TemplateCollectionView!
    var editSelection:editSelection!
    @IBOutlet weak var templateCollectionHeight: NSLayoutConstraint!

    var widget:WidgetCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        templateCollection.register(CalendarTemplateCollectionViewCell.self, forCellWithReuseIdentifier: CalendarTemplateCollectionViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let widgetMaxSize = Dimentions.getWidgetSizeFor("large")
        templateCollectionHeight.constant = widgetMaxSize.height - 80
    }
    
    @IBAction func editBtnClicked(){
        dismiss(animated: true) {
            self.editSelection!()
        }
    }
    
    @IBAction func setWidgetBtnClicked(){
        
        
        if let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupId) {
            print(documentsDirectory)
            let imagePath = (documentsDirectory.appendingPathComponent("\(widget?.id ?? "widget")-bgImage.png"))
            let image = UIImage(named: widget.background!)
            try! image?.pngData()?.write(to: imagePath)
            widget.background = imagePath.path
            var newWidget = WidgetCollection(context: CoreDataStorage.mainQueueContext())
            newWidget = widget
            newWidget.id = NSUUID().uuidString
            newWidget.background = widget.background
            } else {
                print("Error")
            }
       
        
//        let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupId)
//
//        let imagePath = (documentsDirectory?.appendingPathComponent("\(widget?.id ?? "widget")-bgImage.png"))!
//        let image = UIImage(named: widget.background!)
//        try! image?.pngData()?.write(to: imagePath)
//        widget.background = imagePath.path
//
//        var newWidget = WidgetCollection(context: CoreDataStorage.mainQueueContext())
//        newWidget = widget
//        newWidget.id = NSUUID().uuidString

        dismissMe()
    }
}

extension PreviewWidgetViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionView  =  collectionView as? TemplateCollectionView else { return UICollectionViewCell() }

        var cell: TemplateCollectionViewCell!

//        if widget?.type == WidgetType.calendar.rawValue{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarTemplateCollectionViewCell.identifier, for: indexPath) as? CalendarTemplateCollectionViewCell
//        }
//        else if widget?.type == WidgetType.quote.rawValue{
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteTemplateCollectionViewCell.identifier, for: indexPath) as? QuoteTemplateCollectionViewCell
//        }
//        else{
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReminderTemplateCollectionViewCell.identifier, for: indexPath) as? ReminderTemplateCollectionViewCell
//        }
        
        let template = TemplateWidget(widget: widget!)

        if indexPath.section == 0{
            cell?.setItem(template, sizeType: "small", canDelete: false)
        }
        if indexPath.section == 1{
            cell?.setItem(template, sizeType: "medium", canDelete: false)
        }
        if indexPath.section == 2{
            cell?.setItem(template, sizeType: "large", canDelete: false)
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let widgetCollection = self.widget
        if let customizeWidgetView = self.storyboard?.instantiateViewController(withIdentifier: "MakeStyleViewController") as? MakeStyleViewController{
            customizeWidgetView.widget = widgetCollection
            self.push(customizeWidgetView)
        }
    }
}

extension PreviewWidgetViewController:UICollectionViewDelegateFlowLayout{
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
            return CGSize(width: widgetMaxSize.width - 100, height: widgetMaxSize.height - 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 50, left: 40, bottom: 0, right: 0)
        }
        if section == 1{
            return UIEdgeInsets(top: 50, left: 40, bottom: 0, right: 0)
        }
        
        return UIEdgeInsets(top: 25, left: 40, bottom: 0, right: 0)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
