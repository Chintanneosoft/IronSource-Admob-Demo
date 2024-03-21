//
//  WidgetTemplatesViewController.swift
//  Widgets
//
//  Created by Apple on 15/10/20.
//

import UIKit
import CoreData
import IronSource

typealias templateSelection = ((WidgetCollection) -> Void)?
class WidgetTemplatesViewController: UIViewController {
    
    
    @IBOutlet var viewBg: UIView!
    
    
    @IBOutlet weak var templatesTable: UITableView!
    var sections:[String] = []
    var colors:[UIColor]=[UIColor.black,UIColor.green,UIColor.orange,UIColor.yellow,UIColor.blue,UIColor.brown,UIColor.systemPink,UIColor.systemRed,UIColor(named: "DarkColor")!,UIColor.magenta]
    var allTemplates:[TemplateWidget] = []
    var templateSelection:templateSelection!
//    MARK: - Tapcount Variable
    var tapCount = 0
//    MARK: - Intertitial Variable
    var interstitialDelegate: IntertitialDelegate! = nil
    var initializationDelegate: InitializationDelegate! = nil
//    MARK: - App key
    var appKey = "1dd4517e5"
    
    var pullUpControl: SOPullUpControl? {
         didSet {
             pullUpControl?.delegate = self
         }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
      
//        let gradient = CAGradientLayer()
//        gradient.frame = view.bounds
//        gradient.colors = [ViewController.UIColorFromRGB(0x003399).cgColor, ViewController.UIColorFromRGB(0x003399).cgColor]
//        gradient.startPoint = CGPoint.zero
//        gradient.endPoint = CGPoint(x: 0.5, y: 0.5)
//        viewBg.layer.insertSublayer(gradient, at: 0)
        
        
        templatesTable.backgroundColor = UIColor(named: "DarkColor")//UIColor(hexString: "003399")
        templatesTable.backgroundView = UIView(frame: CGRect.zero)
        loadTemplates()
        // MARK: - SetIronSource Delegate Method Called
        setIronSource()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceivePurchaseNotif), name: NSNotification.Name(rawValue: "purchaseNotification"), object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
//    MARK: - Set IronSource Method
    func setIronSource(){
        interstitialDelegate = .init(delegate: self)
        IronSource.setLevelPlayInterstitialDelegate(interstitialDelegate)
        
        IronSource.initWithAppKey(appKey, delegate: self.initializationDelegate)
    }
    
    @objc func onDidReceivePurchaseNotif(){
        sections = []
        allTemplates = []
        loadTemplates()
    }
    
    func loadTemplates() {
        sections.append("Starter")
        sections.append("Love")
        sections.append("Sports")
        sections.append("Pro")
        sections.append("Dark")
       
        sections.append("Light")
        sections.append("Color")
        sections.append("Galaxy")
        sections.append("Gardient")
        sections.append("City")
       
       

        let isPro = UserDefaults.standard.bool(forKey: "isPro")
        
        for section in sections{
            var templates = getTemplates(of: section)
            templates = templates.map({ (template) -> TemplateWidget in
                template.type = section
                if section == "Pro" && isPro == false{
                    template.isPro = 1
                }
                else{
                    template.isPro = 0
                }
                return template
            })
            allTemplates.append(contentsOf: templates)
        }
        templatesTable.reloadData()
    }
    
    func getTemplates(of type:String) -> [TemplateWidget]{
        var templates:[TemplateWidget] = []
        if let path = Bundle.main.path(forResource: type, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let templatesList = jsonResult as? [[String:Any]]{
                    for template in templatesList{
                        let templateObj = TemplateWidget(json: template)
                        templates.append(templateObj)
                    }
                }
            }catch {
                // handle error
           }
        }
        
        return templates
    }
}

extension WidgetTemplatesViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: 220 , height: 40))
        
        label.center = view.center
        
        label.textAlignment = .center
        //label.textColor = UIColor.white
        label.font = UIFont(name: Fonts.BoldFont!.fontName, size: 30)
        label.text = sections[section].capitalizingFirstLetter()
        
        //label.backgroundColor = UIColor(hexString: "212121")//UIColor.darkGray
        label.textColor = UIColor.white
        
        //label.applyGradientWith(startColor: .white, endColor: .black)
        
        
        //label.roundCorner()
        //colors[section]
        
        view.backgroundColor = UIColor.clear
        view.dropShadow()
        view.addSubview(label)
        //label.transform = CGAffineTransform(rotationAngle: 0.1);
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TemplateGroupTableViewCell.identifier, for: indexPath) as! TemplateGroupTableViewCell
        let templates = allTemplates.filter({$0.type == sections[indexPath.section]})
        cell.templateCollection.templateWidgets = templates
        cell.templateCollection.reloadData()
        cell.backgroundColor = UIColor(named:"DarkColor")//UIColor(hexString: "003399")
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        var rotation = CATransform3DMakeRotation( CGFloat((30.0 * Double.pi)/180), 0.0, 0.7, 0.4);
        rotation.m34 = 1.0 / -600
        
        //2. Define the initial state (Before the animation)
        cell.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        cell.alpha = 0;
        cell.layer.transform = rotation;
        cell.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        
        //3. Define the final state (After the animation) and commit the animation
        cell.layer.transform = rotation
        UIView.animate(withDuration: 0.8, animations:{cell.layer.transform = CATransform3DIdentity})
        cell.alpha = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        UIView.commitAnimations()

        
    }
    
    
}

extension WidgetTemplatesViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let collectionView  =  collectionView as? TemplateCollectionView else {
            return 0
        }
        return collectionView.templateWidgets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionView  =  collectionView as? TemplateCollectionView else { return UICollectionViewCell() }

        let template = collectionView.templateWidgets[indexPath.section]

//        if template.type == WidgetType.calendar.rawValue{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarTemplateCollectionViewCell.identifier, for: indexPath) as? CalendarTemplateCollectionViewCell
//            let calendarTemplate = (template as? TemplateWidget)!
            cell?.setItem(template, sizeType: "small", canDelete: false)
            cell?.backgroundColor = UIColor(named:"DarkColor")//UIColor(hexString: "003399")
            collectionView.backgroundColor = UIColor(named:"DarkColor")//UIColor(hexString: "003399")
            return cell!
//        }
//        else if template.type == WidgetType.reminder.rawValue{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReminderTemplateCollectionViewCell.identifier, for: indexPath) as? ReminderTemplateCollectionViewCell
//
////            let calendarTemplate = (template as? TemplateWidget)!
//            cell?.setItem(template, sizeType: "medium", canDelete: false)
//            return cell!
//        }
//        else{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteTemplateCollectionViewCell.identifier, for: indexPath) as? QuoteTemplateCollectionViewCell
//
////            let calendarTemplate = (template as? TemplateWidget)!
//            cell?.setItem(template, sizeType: "medium", canDelete: false)
//            return cell!
//        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        MARK: - Manage Tap count and show Ads
        if tapCount == 0 {
            IronSource.loadInterstitial()
        }else if tapCount == 2{
            tapCount = 0
            if IronSource.hasInterstitial() {
                IronSource.showInterstitial(with: self)
            }
        }
//        MARK: - Increase Tap count
        tapCount += 1
        guard let collectionView  =  collectionView as? TemplateCollectionView else { return }

        let template = collectionView.templateWidgets[indexPath.section]
         self.templateSelection!(template.toWidgetCollection())
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//        UIView.animate(withDuration: 0.9, animations: {
//               cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
//               },completion: { finished in
//                UIView.animate(withDuration: 0.1, animations: {
//                       cell.layer.transform = CATransform3DMakeScale(1,1,1)
//                   })
//           })
        
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.9, delay: 0.05 * Double(indexPath.row), animations: {
              cell.alpha = 1
        })
        
    }
    
}

extension WidgetTemplatesViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width - 50, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension WidgetTemplatesViewController:SOPullUpViewDelegate{
    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        
    }
    
    func pullUpHandleArea(_ sender: UIViewController) -> UIView {
        return self.view
    }
}
//MARK: - Extension of IronSource Delegate
extension WidgetTemplatesViewController: AdViewControllerDelegate{
    func setAndBindBannerView(_ bannerView: ISBannerView!) {
        
    }
}
