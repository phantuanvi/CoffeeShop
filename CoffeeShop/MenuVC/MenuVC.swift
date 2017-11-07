//
//  MenuVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class MenuVC: UIViewController {
    
    // MARK: - create variables
    var menusArray: [Menu] = []
    var menusGetFromFirebase: Array<[String: String]>!
    var titleNav: String = "Menu"
    
    let menuView = MenuView()
    
    // MARK: Lifecycle
    override func loadView() {
        view = menuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        let group = DispatchGroup()
        
        group.enter()
        PTVDataService.sharedInstance.getMenusFromFirebase(complete: { (success) in
            if success {
                let data = PTVDataService.sharedInstance.menusFromFirebase
                self.menusArray = self.parseData(data: data)
                group.leave()
            }
        })
        group.notify(queue: .main) {
            print("menusArray: ", self.menusArray)
            self.menuView.tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuVCCell")
            self.setNavigationBarItem()
            self.navigationController?.hidesBarsOnSwipe = true
            self.navigationItem.title = self.titleNav
            
            self.view.backgroundColor = UIColor.clear
            
            self.menuView.tableView.delegate = self
            self.menuView.tableView.dataSource = self
            SVProgressHUD.dismiss(withDelay: TimeInterval(1), completion: {
                self.menuView.tableView.reloadData()
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStatusBarColor(UIBarStyle.blackTranslucent)
    }
    
    func parseData(data: [[String: String]]?) -> [Menu]{
        var menus = [Menu]()
        if let data = data {
            for menu in data {
                guard let title = menu["title"] else { return menus }
                guard let description = menu["description"] else { return menus }
                guard let urlPicture = menu["urlPicture"] else { return menus }
                let m = Menu(title: title, description: description, urlPicture: urlPicture)
                menus.append(m)
            }
        }
        return menus
    }
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("menusArray.count: ", self.menusArray.count)
        return self.menusArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuVCCell", for: indexPath) as? MenuTableViewCell
        
        if let cell = cell {
            let resource: ImageResource = ImageResource(downloadURL: URL(string: menusArray[indexPath.row].urlPicture)!)
            cell.bgView.kf.setImage(with: resource)
            cell.titleLabel.text = menusArray[indexPath.row].title
            cell.detailLabel.text = menusArray[indexPath.row].description
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = MenuDetailVC()
        detailVC.titleNav = menusArray[indexPath.row].title
        self.navigationController?.pushViewController(detailVC, animated: true)
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
