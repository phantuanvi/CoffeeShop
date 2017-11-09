//
//  MenuDetailTableViewCell.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class MenuDetailTableViewCell: UITableViewCell {
    
    // MARK: create variables
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var titleProductLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 16)
        label.textColor = .black
        return label
    }()
    lazy var detailProductLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSansLight-Italic", size: 13)
        label.textColor = .darkGray
        return label
    }()
    lazy var costProductLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 14)
        label.textColor = .black
        return label
    }()
    lazy var favoriteCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 14)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var favoriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "favorite")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // MARK: life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sv(
            productImageView,
            titleProductLabel,
            detailProductLabel,
            costProductLabel,
            favoriteCountLabel,
            favoriteIcon
        )
        
        productImageView.CenterY == contentView.CenterY
        productImageView.Left == contentView.Left + 20
        productImageView.width(70).height(70)
        
        detailProductLabel.CenterY == contentView.CenterY
        detailProductLabel.Left == productImageView.Right + 20
        detailProductLabel.Right == contentView.Right - 20
        
        titleProductLabel.Left == productImageView.Right + 20
        titleProductLabel.Right == contentView.Right - 20
        titleProductLabel.Bottom == detailProductLabel.Top - 5
        
        costProductLabel.Top == detailProductLabel.Bottom + 5
        costProductLabel.Left == productImageView.Right + 20
        
        favoriteCountLabel.CenterY == costProductLabel.CenterY
        favoriteCountLabel.Right == contentView.Right - 20
        favoriteCountLabel.Left == favoriteIcon.Right + 10
        
        favoriteIcon.CenterY == costProductLabel.CenterY
        favoriteIcon.width(20).height(20)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        favoriteIcon.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: create functions
    @objc func favoriteTapped() {
        tapFavoriteAction?(self)
    }
    
    var tapFavoriteAction: ((MenuDetailTableViewCell) -> Void)?
}
