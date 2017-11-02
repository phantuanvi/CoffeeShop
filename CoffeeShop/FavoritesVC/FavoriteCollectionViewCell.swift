//
//  FavoriteCollectionViewCell.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    // MARK: create variables
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 17)
        label.textColor = UIColor.darkGray
        label.text = "Dark Roast"
        label.textAlignment = .left
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 13)
        label.textColor = UIColor.lightGray
        label.text = "Blue Ridge Blend"
        label.textAlignment = .left
        return label
    }()
    
    lazy var productImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "darkRoast")
        return imgView
    }()
    
    lazy var costLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 15)
        label.textColor = MYGREEN
        label.text = "$10.50"
        label.textAlignment = .left
        return label
    }()
    
    let heartImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "favorite")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imgView.tintColor = UIColor.red
        return imgView
    }()
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        addViews()
        addConstraints()
        
        sv(
            titleLabel,
            detailLabel,
            productImageView,
            costLabel,
            heartImageView
        )
        
        productImageView.centerHorizontally()
        costLabel.height(20)
        heartImageView.size(15)
        
        layout(
            10,
            |-10-titleLabel-10-| ~ 20,
            5,
            |-10-detailLabel-10-| ~ 20,
            10,
            productImageView,
            "",
            |-10-costLabel-0-heartImageView-10-|,
            5
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: create functions
    private func addViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(productImageView)
        contentView.addSubview(costLabel)
        contentView.addSubview(heartImageView)
    }
    
    private func addConstraints() {
        contentView.addConstraints(withFormat: "V:|-10-[v0(20)]-5-[v1(20)]-10-[v2][v3(20)]", views: titleLabel, detailLabel, productImageView, costLabel)
        
        contentView.addConstraints(withFormat: "V:[v0][v1(15)]-10-|", views: productImageView, heartImageView)
        
        contentView.addConstraints(withFormat: "H:|-10-[v0][v1(15)]-10-|", views: costLabel, heartImageView)
        
        NSLayoutConstraint(item: productImageView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    }
}
