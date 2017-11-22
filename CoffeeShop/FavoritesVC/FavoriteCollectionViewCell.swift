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
        return imgView
    }()
    
    lazy var costLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 15)
        label.textColor = MYGREEN
        label.textAlignment = .left
        return label
    }()
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        
        sv(
            titleLabel,
            detailLabel,
            productImageView,
            costLabel
        )
        
        productImageView.centerHorizontally()
        costLabel.height(20)
        
        layout(
            10,
            |-10-titleLabel-10-| ~ 20,
            5,
            |-10-detailLabel-10-| ~ 20,
            10,
            |-10-productImageView-10-|,
            "",
            |-10-costLabel,
            5
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
