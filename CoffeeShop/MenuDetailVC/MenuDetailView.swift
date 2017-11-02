//
//  MenuDetailView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class MenuDetailView: UIView {
    
    // MARK: create variables
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect.zero
        tableView.register(MenuDetailTableViewCell.self, forCellReuseIdentifier: "menuDetailTVCell")
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.contentInset = UIEdgeInsets.zero
        tableView.tableHeaderView = MenuDetailTableHeaderView()
        return tableView
    }()
    
    // MARK: life cycle
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
