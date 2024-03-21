//
//  TemplateGroupTableViewCell.swift
//  Widgets
//
//  Created by Apple on 15/10/20.
//

import UIKit

class TemplateGroupTableViewCell: UITableViewCell {
    @IBOutlet weak var templateCollection: TemplateCollectionView!
    @IBOutlet weak var groupName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        templateCollection.register(CalendarTemplateCollectionViewCell.self, forCellWithReuseIdentifier: CalendarTemplateCollectionViewCell.identifier)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .horizontal
        templateCollection.collectionViewLayout = layout
        
        // Initialization code
    }
    
    static var identifier:String{
        return String(describing: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
