//
//  SideBarVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Firebase

enum LeftMenu: Int {
    case menu = 0
    case favorites
    case settings
}

protocol LeftMenuProtocol: class {
    func changeViewController(_ menu: LeftMenu)
}

class SideBarVC: UIViewController, LeftMenuProtocol {
    
    // MARK: - create variables
    let menusArray = ["Menu", "Favorites", "Settings"]
    var isMenuBlue: Bool = PTVAuthService.sharedInstance.isMenuBlue!
    
    var menuVC: UIViewController!
    var favoritesVC: UIViewController!
    var settingsVC: UIViewController!
    let sideBarView = SideBarView()
    
    //MARK: Lifecycle
    override func loadView() {
        view = sideBarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isMenuBlue = true
        setupViewControllers()
        
        sideBarView.tableView.dataSource = self
        sideBarView.tableView.delegate = self
    }
    
    // MARK: create functions
    private func setupViewControllers(){
        let favoritesVC: FavoritesVC = FavoritesVC()
        self.favoritesVC = UINavigationController(rootViewController: favoritesVC)
        
        let settingsVC: SettingsVC = SettingsVC()
        self.settingsVC = UINavigationController(rootViewController: settingsVC)
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .menu: self.slideMenuController()?.changeMainViewController(self.menuVC, close: true)
        case .favorites: self.slideMenuController()?.changeMainViewController(self.favoritesVC, close: true)
        case .settings: self.slideMenuController()?.changeMainViewController(self.settingsVC, close: true)
        }
    }
}

extension SideBarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menusArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .menu, .favorites, .settings:
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "SideBarCell")
                cell.backgroundColor = UIColor.clear
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.textLabel?.text = "\(menusArray[indexPath.row])"
                cell.textLabel?.textColor = WHITE
                if (isMenuBlue) {
                    cell.textLabel?.textColor = MYGREEN
                    isMenuBlue = false
                }
                return cell
            }
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
            print("didSelectRow \(menu)")
        }
        tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.textColor = WHITE
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = MYGREEN
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            print("didDeselectRow \(menu)")
        }
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = WHITE
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == menusArray.count {
            return self.sideBarView.tableView.bounds.size.height - 150
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = SideBarTableFooterView()
        footerView.logOutButton?.tap(logOutTapped)
        footerView.logInButton?.tap(logInTapped)
        footerView.registerButton?.tap(registerTapped)
        return footerView
    }
    
    private func logOutTapped() {
        print("logout")
        do {
            try Auth.auth().signOut()
            PTVAuthService.sharedInstance.isAuthenticated = false
            print(Auth.auth())
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        isMenuBlue = true
        self.sideBarView.tableView.reloadData()
        self.sideBarView.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.none)
    }
    
    private func logInTapped() {
        print("logInTapped")
        isMenuBlue = true
        self.sideBarView.tableView.reloadData()
        let signInVC = SignInViewController()
        present(signInVC, animated: true, completion: nil)
    }
    
    private func registerTapped() {
        print("registerTapped")
        isMenuBlue = true
        self.sideBarView.tableView.reloadData()
        let signUpVC = SignUpViewController()
        present(signUpVC, animated: true, completion: nil)
    }
}
