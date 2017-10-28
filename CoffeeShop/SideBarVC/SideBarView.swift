//
//  SideBarView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class SideBarView: UIView {
    
    // MARK: create views
    let backgroundView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "backgroundCoffee")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect.zero
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SideBarCell")
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.allowsSelection = true
        return tableView
    }()
    
    let logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = MYGREEN
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = MYGREEN
        button.isUserInteractionEnabled = true
        return button
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        render()
    }
    
    private func render() {
        sv(
            backgroundView,
            tableView,
            logInButton,
            registerButton
        )
        
        backgroundView.fillContainer()
        logInButton.height(60)
        equalSizes(logInButton, registerButton)
        
        layout(
            "",
            |-20-tableView| ~ 272,
            80,
            |logInButton-0-registerButton|,
            0
        )
    }
}
