//
//  OrderSummaryView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class OrderSummaryView: UIView {
    
    // MARK: create variables
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let productImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "chickenSalad")
        return imgView
    }()
    
    let nameProductLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 22)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = "Chicken Salad"
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect.zero
        tableView.register(OrderSummaryTableViewCell.self, forCellReuseIdentifier: "OrderSummaryVCCell")
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.lightGray
        tableView.contentInset = UIEdgeInsets.zero
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    let totalView: UIView = {
        let view = UIView()
        return view
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 20)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Total:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalCostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 20)
        label.textColor = MYGREEN
        label.textAlignment = .center
        label.text = "$13.20"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var confirmOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm The Order", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = MYGREEN
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var cancelOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel The Order", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = UIColor.clear
        button.isUserInteractionEnabled = true
        return button
    }()
    
    // MARK: life cycle
    convenience init() {
        self.init(frame: CGRect.zero)
        
        render()
    }
    
    private func render() {
        
        totalView.addTopBorder(UIColor.lightGray, width: 2)
        totalView.addBottomBorder(UIColor.lightGray, width: 2)
        
        sv(
            scrollView.sv(
                contentView.sv(
                    productImageView,
                    nameProductLabel,
                    tableView,
                    totalView,
                    totalLabel,
                    totalCostLabel,
                    confirmOrderButton,
                    cancelOrderButton
                )
            )
        )
        
        scrollView.fillContainer()
        equalWidths(scrollView, contentView)
        contentView.height(700)
        contentView.Top == scrollView.Top
        contentView.Bottom == scrollView.Bottom
        
        totalLabel.CenterY == totalView.CenterY
        totalLabel.Left == totalView.Left + 20
        
        totalCostLabel.CenterY == totalView.CenterY
        totalCostLabel.Right == totalView.Right - 20
        productImageView.centerHorizontally()
        
        layout(
            0,
            |productImageView|,
            10,
            |-15-nameProductLabel-10-| ~ 25,
            5,
            |-10-tableView-10-| ~ 251,
            5,
            |-0-totalView-0-| ~ 55,
            10,
            |-10-confirmOrderButton-10-| ~ 50,
            10,
            |-10-cancelOrderButton-10-| ~ 50,
            10
        )
    }
}
