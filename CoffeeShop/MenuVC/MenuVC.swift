//
//  MenuVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit

struct MenuModel {
    let menuTitle: String
    let menuDetail: String
    let menuImage: String
    
    init(title: String, detail: String, image: String) {
        menuTitle = title
        menuDetail = detail
        menuImage = image
    }
}

class MenuVC: UIViewController {
    
    // MARK: - create sub views and func
    var menuArrays: [MenuModel] = []
    var titleNav: String = "Menu"
    
    let menuView = MenuView()
    
    func setupModel() {
        let menu1 = MenuModel(title: "Coffee", detail: "Freshly brewed coffee", image: "menuCoffee.png")
        menuArrays.append(menu1)
        let menu2 = MenuModel(title: "Breakfast", detail: "Perfectly baked & served warm", image: "menuBreakfast.png")
        menuArrays.append(menu2)
        let menu3 = MenuModel(title: "Munchies", detail: "Perfectly baked & served warm", image: "menuMunchies.png")
        menuArrays.append(menu3)
        let menu4 = MenuModel(title: "Sandwiches", detail: "Fresh, healthy and tasty", image: "menuSandwiches.png")
        menuArrays.append(menu4)
        let menu5 = MenuModel(title: "Specialty Drinks", detail: "Special drinks for every taste", image: "menuSpecialtyDrinks.png")
        menuArrays.append(menu5)
    }
    
    //MARK: Lifecycle
    override func loadView() {
        view = menuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupModel()
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.title = titleNav
        self.setNavigationBarItem()
        
        view.backgroundColor = UIColor.black
        menuView.tableView.delegate = self
        menuView.tableView.dataSource = self
    }
    
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuVCCell", for: indexPath) as? MenuTableViewCell
        
        if let cell = cell {
            cell.bgView.image = UIImage(named: menuArrays[indexPath.row].menuImage)
            cell.titleLabel.text = menuArrays[indexPath.row].menuTitle
            cell.detailLabel.text = menuArrays[indexPath.row].menuDetail
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(menuArrays[indexPath.row].menuTitle)")
    }
}

extension MenuVC : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        //        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        //        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        //        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        //        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        //        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        //        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        //        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        //        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
