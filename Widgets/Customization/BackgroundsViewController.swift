//
//  ViewController.swift
//  DailyQuotesWidget
//
//  Created by Apple on 07/10/20.
//

import UIKit

class BackgroundsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var selectionImage: UIImageView!

    override func awakeFromNib() {
        bgImage.roundCorner(20)
        selectionImage.isHidden = true
    }
    
    override func prepareForReuse() {
        bgImage.image = nil
    }
    
    func setItem(_ name: String , isSelected: Bool) {
        let image = UIImage(named: name)

        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                self.bgImage.image = image
            })
        }
        
        selectionImage.image = isSelected == true ? UIImage(named: "selected_checkbox") : UIImage(named: "checkbox")
    }
}

protocol BackgroundsViewDelegate {
    func backgroundSelected(_ image: UIImage)
}

class BackgroundsViewController: UIViewController {
    @IBOutlet weak var backgroundCollectionView: UICollectionView!
    
    var backgrounds:[String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13"]
//    var selectedBackgrounds:[String] = []
    var delegate:BackgroundsViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        selectedBackgrounds = defaults?.value(forKey: "selectedBackgrounds") as? [String] ?? []
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func settingBtnClicked(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let makeStyleView = storyboard.instantiateViewController(withIdentifier: "ManagePurchaseViewController") as? ManagePurchaseViewController
        self.navigationController?.pushViewController(makeStyleView!, animated: true)
    }
}

extension BackgroundsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return backgrounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BackgroundsCollectionViewCell", for: indexPath) as? BackgroundsCollectionViewCell
        cell?.setItem(backgrounds[indexPath.row], isSelected: false)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isPro = UserDefaults.standard.value(forKey: Constants.proProduct) as? Bool ?? false

//        if isPro == true || indexPath.row < Constants.freeBackgroundImagesCount{
//            selectedBackgrounds.removeAll()
//            selectedBackgrounds.append(backgrounds[indexPath.row])
            backgroundCollectionView.reloadData()
            
            delegate?.backgroundSelected(UIImage(named: backgrounds[indexPath.row])!)
//        }
//        else{
//            self.showAlertMessage(title: "Buy pro version to use this background")
//        }
    }
}

extension BackgroundsViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 40 , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
