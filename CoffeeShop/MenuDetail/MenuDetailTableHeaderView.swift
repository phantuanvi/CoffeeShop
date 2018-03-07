//
//  MenuDetailTableHeaderView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class MenuDetailTableHeaderView: UIView {
    
    // MARK: create variables
    let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "headerImage")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSansLight-Italic", size: 13)
        label.textColor = COFFEECOLOR
        label.text = "Special Offer"
        return label
    }()
    
    let nameProductLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-BoldItalic", size: 24)
        label.textColor = COFFEECOLOR
        label.text = "Esspresso"
        return label
    }()
    
    let detailProductLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSansLight-Italic", size: 13)
        label.textColor = COFFEECOLOR
        label.text = "Blue Ridge Blend"
        return label
    }()
    
    let costLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 14)
        label.textColor = WHITE
        label.text = "$5.55"
        return label
    }()
    
    let oldCostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 14)
        label.textColor = WHITE
        label.text = "$3.55"
        return label
    }()

    // MARK: life cycle
    convenience init() {
        self.init(frame: CGRect.zero)
        render()
    }
    
    private func render() {
        sv(
            headerImageView,
            titleLabel,
            nameProductLabel,
            detailProductLabel,
            costLabel,
            oldCostLabel
        )
        headerImageView.followEdges(self)
        nameProductLabel.CenterX == self.CenterX
        nameProductLabel.CenterY == self.CenterY
        
        titleLabel.CenterX == self.CenterX
        titleLabel.Bottom == nameProductLabel.Top - 8
        
        detailProductLabel.CenterX == self.CenterX
        detailProductLabel.Top ==  nameProductLabel.Bottom + 8
        
        costLabel.Right == self.CenterX - 20
        costLabel.Top == detailProductLabel.Bottom + 8
        
        oldCostLabel.Left == self.CenterX + 20
        oldCostLabel.Top == detailProductLabel.Bottom + 8
    }

}
