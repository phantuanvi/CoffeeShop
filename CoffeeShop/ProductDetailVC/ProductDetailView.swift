//
//  ProductDetailView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import ZHDropDownMenu
import Stevia

class ProductDetailView: UIView {
    
    let productImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "chocolateMuffin")
        return imgView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Our muffin unites rich, dense chocolate with a gooey caramel center for bliss in every bite. As far as we're concerned, there's no such thing as too much caramel."
        textView.textColor = UIColor.lightGray
        textView.isEditable = false
        return textView
    }()
    
    let quantityView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let totalView: UIView = {
        let view = UIView()
        return view
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.text = "Quantity"
        return label
    }()
    
    let quantityMenu: ZHDropDownMenu = {
        let menu = ZHDropDownMenu()
        menu.options = ["1", "2", "3", "4", "5"]
        menu.defaultValue = "1"
        menu.font = UIFont(name: "OpenSans", size: 18)
        menu.buttonImage = UIImage(named: "down")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        menu.tintColor = UIColor.lightGray
        menu.textColor = UIColor.lightGray
        menu.showBorder = false
        return menu
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Total"
        return label
    }()
    
    let costLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 20)
        label.textColor = MYGREEN
        label.textAlignment = .center
        label.text = "$20"
        return label
    }()
    
    let placeOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Place The Order", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = MYGREEN
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let addToFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to favorites", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans", size: 16)
        button.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = UIColor.clear
        button.isUserInteractionEnabled = true
        return button
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        render()
    }
    
    private func render() {
        
        quantityView.addTopBorder(UIColor.lightGray, width: 2)
        quantityView.addRightBorder(UIColor.lightGray, width: 2)
        quantityView.addBottomBorder(UIColor.lightGray, width: 2)
        
        totalView.addTopBorder(UIColor.lightGray, width: 2)
        totalView.addBottomBorder(UIColor.lightGray, width: 2)
        
        sv(
            productImageView,
            descriptionTextView,
            quantityView.sv(
                quantityLabel
            ),
            quantityMenu,
            totalView.sv(
                totalLabel,
                costLabel
            ),
            placeOrderButton,
            addToFavoriteButton
        )
        
        productImageView.width(200).centerHorizontally()
        equalWidths(quantityView, totalView)
        
        layout(
            64,
            productImageView,
            5,
            |-20-descriptionTextView-20-| ~ 70,
            5,
            |quantityView-0-totalView| ~ 80,
            10,
            |-10-placeOrderButton-10-| ~ 50,
            10,
            |-10-addToFavoriteButton-10-| ~ 50,
            10
        )
        
        quantityMenu.width(60).height(30)
        quantityMenu.Top == quantityLabel.Bottom + 10
        quantityMenu.CenterX == quantityView.CenterX
        layout(
            10,
            |quantityLabel| ~ 20
        )
        
        layout(
            10,
            |totalLabel| ~ 20,
            10,
            |costLabel| ~ 30,
            ""
        )
    }
}
