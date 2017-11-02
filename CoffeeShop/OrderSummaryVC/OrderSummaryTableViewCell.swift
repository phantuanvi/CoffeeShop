//
//  OrderSummaryTableViewCell.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class OrderSummaryTableViewCell: UITableViewCell {
    
    // MARK: create variables
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 16)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 16)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    // MARK: life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sv(
            titleLabel,
            detailLabel
        )
        
        titleLabel.CenterY == contentView.CenterY
        detailLabel.CenterY == contentView.CenterY
        
        |-10-titleLabel
        detailLabel-10-|
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
