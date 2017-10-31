//
//  WelcomeVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {
    let welcomeView = WelcomeView()
    
    //MARK: Lifecycle
    override func loadView() {
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeView.signUpButton.tap(signUpTapped)
        welcomeView.skipButton.tap(skipTapped)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//            if user != nil {
//                let menuVC:MenuVC = MenuVC()
//                let sideBarVC:SideBarVC = SideBarVC()
//                let navigationController:UINavigationController = UINavigationController(rootViewController: menuVC)
//                sideBarVC.menuVC = navigationController
//                let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: sideBarVC)
//                slideMenuController.delegate = menuVC
//                self.present(slideMenuController, animated: true, completion: nil)
//            }
//        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func signUpTapped(){
        print("signUpTapped")
        let signUpVC = SignUpVC()
        present(signUpVC, animated: true, completion: nil)
    }
    
    private func skipTapped() {
        print("skipTapped")
        let signInVC = SignInVC()
        present(signInVC, animated: true, completion: nil)
    }
}
