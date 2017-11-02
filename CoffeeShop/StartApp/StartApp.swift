//
//  StartApp.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/31/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit

class StartApp {
    // MARK: create variable
    static let shared = StartApp()
    
    func start(handler: (UIViewController) -> ()) {
        let menuVC:MenuVC = MenuVC()
        let sideBarVC:SideBarVC = SideBarVC()
        let navigationController:UINavigationController = UINavigationController(rootViewController: menuVC)
        sideBarVC.menuVC = navigationController
        let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: sideBarVC)
        slideMenuController.delegate = menuVC
        handler(slideMenuController)
    }
}
