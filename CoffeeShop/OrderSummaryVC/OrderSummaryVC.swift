//
//  OrderSummaryVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
class OrderSummaryVC: UIViewController {
    
    let orderSummaryView = OrderSummaryView()
    
    func confirmOrderTapped() {
        print("confirmOrderTapped")
    }
    
    func cancelOrderTapped() {
        print("cancelOrderTapped")
    }
    
    // Left Bar Button Item
    func leftBarButtonItem() {
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        leftButton.tintColor = UIColor.lightGray
        leftButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        leftButton.addTarget(self, action: #selector(self.leftButtonTapped), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func leftButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Lifecycle
    
    override func loadView() {
        view = orderSummaryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationItem.title = "Order Summary"
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.gray]
        navigationController?.navigationBar.isTranslucent = true
        
        orderSummaryView.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        
        orderSummaryView.tableView.dataSource = self
        orderSummaryView.tableView.delegate = self
        orderSummaryView.confirmOrderButton.tap(confirmOrderTapped)
        orderSummaryView.cancelOrderButton.tap(cancelOrderTapped)
        leftBarButtonItem()
    }
    
}

extension OrderSummaryVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderSummaryVCCell", for: indexPath) as? OrderSummaryTableViewCell
        
        if let cell = cell {
            switch indexPath.row {
            case 0: cell.titleLabel.text = "Base Price";    cell.detailLabel.text = "$12.00";
            case 1: cell.titleLabel.text = "Quantity";      cell.detailLabel.text = "1";
            case 2: cell.titleLabel.text = "Size";          cell.detailLabel.text = "Large";
            case 3: cell.titleLabel.text = "Tax";           cell.detailLabel.text = "$1.20";
            case 4: cell.titleLabel.text = "Subtotal";      cell.detailLabel.text = "$13.20";
            default: cell.titleLabel.text = ""
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
