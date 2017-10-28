//
//  MenuView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class MenuView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect.zero
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuVCCell")
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.white
        tableView.contentInset = UIEdgeInsets.zero
        return tableView
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        render()
    }
    
    private func render() {
        sv(
            tableView
        )
        
        tableView.fillContainer()
    }
}
