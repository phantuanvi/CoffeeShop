//
//  OrderSummaryVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Kingfisher

class OrderSummaryVC: UIViewController {
    
    // MARK: create variables
    let orderSummaryView = OrderSummaryView()
    var product: Product? = nil
    var totalCost: Double = 0
    //MARK: Lifecycle
    
    override func loadView() {
        view = orderSummaryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationItem.title = "Order Summary"
        
        totalCost = Double(product!.newCost * product!.quantity)
        orderSummaryView.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        let resource: ImageResource = ImageResource(downloadURL: URL(string: self.product!.urlPicture!)!)
        orderSummaryView.productImageView.kf.setImage(with: resource)
        orderSummaryView.nameProductLabel.text = product!.name
        orderSummaryView.totalCostLabel.text = "\(totalCost + (totalCost * 0.05))"
        orderSummaryView.tableView.dataSource = self
        orderSummaryView.tableView.delegate = self
        orderSummaryView.confirmOrderButton.tap(confirmOrderTapped)
        orderSummaryView.cancelOrderButton.tap(cancelOrderTapped)
        leftBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.gray]
        navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: create functions
    private func confirmOrderTapped() {
        let alertController = UIAlertController(title: "Order Confirm", message: "You order \(product!.quantity) \(product!.name)", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func cancelOrderTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // Left Bar Button Item
    private func leftBarButtonItem() {
        
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
    
}

extension OrderSummaryVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderSummaryVCCell", for: indexPath) as? OrderSummaryTableViewCell
        
        if let cell = cell {
            switch indexPath.row {
            case 0: cell.titleLabel.text = "Base Price";    cell.detailLabel.text = "$\(product!.newCost)";
            case 1: cell.titleLabel.text = "Quantity";      cell.detailLabel.text = "\(product!.quantity)";
            case 2: cell.titleLabel.text = "Tax";           cell.detailLabel.text = "$\(totalCost * 0.05)";
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
