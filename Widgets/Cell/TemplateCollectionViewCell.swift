//
//  TemplateCollectionViewCell.swift
//  Widgets
//
//  Created by Apple on 15/10/20.
//

import UIKit

class TemplateCollectionViewCell: UICollectionViewCell {
    var deleteBtnAction: ((TemplateCollectionViewCell) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    let containerView: RoundedView = {
        let overlay = RoundedView()
        return overlay
    }()
    
    let overlayView: RoundedView = {
        let overlay = RoundedView()
        return overlay
    }()
    
    let deleteBtn: UIButton = {
        let deleteBtn = UIButton()
        deleteBtn.backgroundColor = UIColor.red
        deleteBtn.setImage(UIImage(named: "trash"), for: .normal)
        deleteBtn.layer.zPosition = 10000
        deleteBtn.isUserInteractionEnabled = true
        return deleteBtn
    }()
    
    let proBtn: UIButton = {
        let proBtn = UIButton()
        proBtn.setImage(UIImage(named: "pro"), for: .normal)
        proBtn.layer.zPosition = 10000
        return proBtn
    }()
    
    let bgImageView: RoundedImageView = {
        let bgImgView = RoundedImageView()
        bgImgView.contentMode = .scaleAspectFill
        return bgImgView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
//        containerView.frame = CGRect(x: 20, y: 20, width: self.bounds.size.width - 40, height: self.bounds.size.height - 40)
        contentView.addSubview(containerView)
        containerView.addSubview(bgImageView)
        containerView.addSubview(overlayView)
        containerView.addSubview(deleteBtn)
        containerView.addSubview(proBtn)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        proBtn.translatesAutoresizingMaskIntoConstraints = false

        contentView.addConstraint(NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))

        contentView.addConstraint(NSLayoutConstraint(item: overlayView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: overlayView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: overlayView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: overlayView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: bgImageView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: bgImageView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: bgImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: bgImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: deleteBtn, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20))
        contentView.addConstraint(NSLayoutConstraint(item: deleteBtn, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20))

        contentView.addConstraint(NSLayoutConstraint(item: deleteBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50))
        contentView.addConstraint(NSLayoutConstraint(item: deleteBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50))
        
        
        contentView.addConstraint(NSLayoutConstraint(item: proBtn, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20))
        contentView.addConstraint(NSLayoutConstraint(item: proBtn, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20))

        contentView.addConstraint(NSLayoutConstraint(item: proBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40))
        contentView.addConstraint(NSLayoutConstraint(item: proBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40))
        
        deleteBtn.addTarget(self, action: #selector(deleteBtnClicked), for: .touchUpInside)
        deleteBtn.layer.cornerRadius = 25
        deleteBtn.layer.masksToBounds = true
    }
    
    @objc func deleteBtnClicked(){
        deleteBtnAction!(self)
    }
    
    static var identifier:String{
        return String(describing: self)
    }
    
    func setItem(_ item: TemplateWidget, sizeType: String , canDelete: Bool) {
        overlayView.backgroundColor =  UIColor.hexStringToUIColor(hex: item.overlayColor).withAlphaComponent(item.overlayAlpha)
        overlayView.layer.borderWidth = CGFloat(item.borderWidth)
        overlayView.layer.borderColor =  UIColor.hexStringToUIColor(hex: item.borderColor).cgColor
        bgImageView.image = UIImage(contentsOfFile: item.bgImage) ?? UIImage(named: item.bgImage)
        
        deleteBtn.isHidden = !canDelete
        proBtn.isHidden = (item.isPro == 0)
    }
}

class CalendarTemplateCollectionViewCell: TemplateCollectionViewCell {
    let headingLabel: PaddingLabel = {
        let headingLabel = PaddingLabel()
        return headingLabel
    }()
    
    let subHeadingLabel: PaddingLabel = {
        let subHeadingLabel = PaddingLabel()
        return subHeadingLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        subHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        containerView.addSubview(headingLabel)
        containerView.addSubview(subHeadingLabel)
        headingLabel.textAlignment = .left
        subHeadingLabel.textAlignment = .center

        containerView.addConstraint(NSLayoutConstraint(item: headingLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: headingLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: headingLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0))

        containerView.addConstraint(NSLayoutConstraint(item: subHeadingLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: subHeadingLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: subHeadingLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0))

    }
    
    override func setItem(_ item: TemplateWidget , sizeType: String , canDelete: Bool) {
        super.setItem(item, sizeType: sizeType, canDelete: canDelete)
        headingLabel.textColor = UIColor.hexStringToUIColor(hex: item.headingLabelTextColor).withAlphaComponent(item.headingLabelTextAlpha)
        subHeadingLabel.textColor = UIColor.hexStringToUIColor(hex: item.subHeadingLabelTextColor).withAlphaComponent(item.subHeadingLabeTextAlpha)

        let variant = item.variants.filter({$0.size == sizeType}).first
        
        headingLabel.setPadding(withInsets: variant!.headingLabelTopPadding, 0, variant!.headingLabelLeftPadding, 10)
        subHeadingLabel.setPadding(withInsets: variant!.subHeadingLabelTopPadding, 0, variant!.subHeadingLabelLeftPadding, 0)

        headingLabel.text = Date().toString(format: variant?.timeFormat ?? "hh:mm")
        subHeadingLabel.text = Date().toString(format: variant?.dateFormat ?? "EEEE\ndd MMMM")

        headingLabel.numberOfLines = 0
        subHeadingLabel.numberOfLines = 0
        headingLabel.textAlignment = .right
        if let matchedVariant = item.variants.filter({$0.size == sizeType}).first{
            headingLabel.font = UIFont(name: item.headingFont, size: CGFloat(matchedVariant.headingLabelFontSize))
            subHeadingLabel.font = UIFont(name: item.subHeadingFont, size: CGFloat(matchedVariant.subHeadingLabelFontSize))
        }
    }
}
