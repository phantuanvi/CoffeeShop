//
//  MenuTableViewCell.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class MenuTableViewCell: UITableViewCell {
    
    let bgView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 13)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sv(
            bgView,
            titleLabel,
            detailLabel
        )
        
        bgView.fillContainer()
        titleLabel.CenterX == contentView.CenterX
        detailLabel.CenterX == contentView.CenterX
        titleLabel.CenterY == contentView.CenterY - 15
        detailLabel.CenterY == contentView.CenterY + 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
