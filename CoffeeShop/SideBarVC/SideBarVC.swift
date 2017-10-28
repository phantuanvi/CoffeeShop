//
//  SideBarVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case menu = 0
    case favorites
    case profile
    case settings
}

protocol LeftMenuProtocol: class {
    func changeViewController(_ menu: LeftMenu)
}

class SideBarVC: UIViewController, LeftMenuProtocol {
    
    // MARK: - create sub views and func
    let menuArrays = ["Menu", "Favorites", "Profile", "Settings"]
    var isRunOneTime: Bool = true
    
    var menuVC: UIViewController!
    var favoritesVC: UIViewController!
    var profileVC: UIViewController!
    var settingsVC: UIViewController!
    let sideBarView = SideBarView()
    
    func logInTapped() {
        print("logInTapped")
        let signInVC = SignInVC()
        present(signInVC, animated: true, completion: nil)
    }
    
    func registerTapped() {
        print("registerTapped")
        let signUpVC = SignUpVC()
        let navController = UINavigationController(rootViewController: signUpVC)
        present(navController, animated: true, completion: nil)
    }
    
    func setupViewControllers(){
        let favoritesVC: FavoritesVC = FavoritesVC()
        self.favoritesVC = UINavigationController(rootViewController: favoritesVC)

        let profileVC: ProfileVC = ProfileVC()
        self.profileVC = UINavigationController(rootViewController: profileVC)

        let settingsVC: SettingsVC = SettingsVC()
        self.settingsVC = UINavigationController(rootViewController: settingsVC)
    }
    
    //MARK: Lifecycle
    override func loadView() {
        view = sideBarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupViewControllers()
        
        sideBarView.tableView.dataSource = self
        sideBarView.tableView.delegate = self
        sideBarView.logInButton.tap(logInTapped)
        sideBarView.registerButton.tap(registerTapped)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (isRunOneTime) {
            sideBarView.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.textColor = MYGREEN
            isRunOneTime = false
            print(isRunOneTime)
        }
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .menu: self.slideMenuController()?.changeMainViewController(self.menuVC, close: true)
        case .favorites: self.slideMenuController()?.changeMainViewController(self.favoritesVC, close: true)
        case .profile: self.slideMenuController()?.changeMainViewController(self.profileVC, close: true)
        case .settings: self.slideMenuController()?.changeMainViewController(self.settingsVC, close: true)
        }
    }
}

extension SideBarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .menu, .favorites, .profile, .settings:
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "SideBarCell")
                cell.backgroundColor = UIColor.clear
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.textLabel?.text = "\(menuArrays[indexPath.row])"
                cell.textLabel?.textColor = WHITE
                return cell
            }
        }
        return UITableViewCell()
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
}
