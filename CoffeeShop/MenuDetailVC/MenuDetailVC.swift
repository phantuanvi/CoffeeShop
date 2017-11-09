//
//  MenuDetailVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia
import SVProgressHUD
import Kingfisher

private let kTableHeaderHeight: CGFloat = 200.0

class MenuDetailVC: UIViewController {
    
    // MARK: create variabvar

    var productsArray = [Product]()
    
    var headerView: UIView!
    let menuDetailView = MenuDetailView()
    
    var titleNav: String = ""
    
    //MARK: Lifecycle
    override func loadView() {
        view = menuDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        let group = DispatchGroup()
        group.enter()
        PTVDataService.sharedInstance.getProductsFromFirebase { (success) in
            let data = PTVDataService.sharedInstance.productsFromFirebase
            self.productsArray = self.parseData(data: data)
            self.productsArray = self.productsArray + self.productsArray
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            self.menuDetailView.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
        
        navigationItem.title = titleNav
        
        leftBarButtonItem()
        
        menuDetailView.tableView.tableHeaderView = menuDetailView.tableView.tableHeaderView
        
        headerView = menuDetailView.tableView.tableHeaderView
        menuDetailView.tableView.tableHeaderView = nil
        menuDetailView.tableView.addSubview(headerView)
        menuDetailView.tableView.contentInset = UIEdgeInsetsMake(kTableHeaderHeight, 0, 0, 0)
        menuDetailView.tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        
        automaticallyAdjustsScrollViewInsets = false
        menuDetailView.tableView.dataSource = self
        menuDetailView.tableView.delegate = self
        
        updateHeaderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:WHITE]
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
        setStatusBarColor(UIBarStyle.blackTranslucent)
    }
    
    override func viewDidLayoutSubviews() {
        updateHeaderView()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    // MARK: create functions
    func parseData(data: [[String: String]]?) -> [Product]{
        var products = [Product]()
        if let data = data {
            for product in data {
                guard let menu = product["menu"] else { return products }
                guard let name = product["name"] else { return products }
                guard let description = product["detail"] else { return products }
                guard let cost = product["cost"] else { return products }
                guard let urlPicture = product["urlPicture"] else { return products }
                let p = Product(name: name, description: description, newCost: Int(cost) ?? 0, oldCost: nil, urlPicture: urlPicture, isFavorite: false, quantity: 1)
                if (menu == titleNav) {
                    products.append(p)
                }
            }
        }
        return products
    }
    
    // Left Bar Button Item
    private func leftBarButtonItem() {
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        leftButton.tintColor = WHITE
        leftButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        leftButton.addTarget(self, action: #selector(self.leftButtonTapped), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func leftButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    private func updateHeaderView() {
        
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: menuDetailView.tableView.bounds.width, height: kTableHeaderHeight)
        
        headerRect.origin.y = menuDetailView.tableView.contentOffset.y
        headerRect.size.height = -menuDetailView.tableView.contentOffset.y
        
        headerView.frame = headerRect
    }
}

extension MenuDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuDetailTVCell", for: indexPath) as! MenuDetailTableViewCell
        
        cell.titleProductLabel.text = productsArray[indexPath.row].name
        cell.detailProductLabel.text = productsArray[indexPath.row].description
        let cost = "$\(productsArray[indexPath.row].newCost)"
        cell.costProductLabel.text = cost
        
        let resource: ImageResource = ImageResource(downloadURL: URL(string: productsArray[indexPath.row].urlPicture!)!)
        cell.productImageView.kf.setImage(with: resource)
        
        cell.tapFavoriteAction = { cell in
            cell.favoriteIcon.image = cell.favoriteIcon.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            if (cell.favoriteIcon.tintColor == .red) {
                cell.favoriteIcon.tintColor = .lightGray
                self.productsArray[indexPath.row].isFavorite = false
                PTVDataService.sharedInstance.favoriteProducts.removeLast()
            } else {
                cell.favoriteIcon.tintColor = .red
                self.productsArray[indexPath.row].isFavorite = true
                PTVDataService.sharedInstance.favoriteProducts.append(self.productsArray[indexPath.row])
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let productDetailVC = ProductDetailVC()
        productDetailVC.product = productsArray[indexPath.row]
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
